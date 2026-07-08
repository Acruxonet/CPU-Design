`timescale 1ns/1ps
`include "ctrl_encode_def.v"

module ctrl(
    input  wire [6:0] Op,
    input  wire [6:0] Funct7,
    input  wire [2:0] Funct3,
    input  wire       Zero,
    output reg       RegWrite,
    output reg       MemWrite,
    output reg [5:0] EXTOp,
    output reg [4:0] ALUOp,
    output reg [2:0] NPCOp,
    output reg       ALUSrc,
    output wire [1:0] GPRSel,
    output reg [1:0] WDSel,
    output reg [2:0] DMType
);
    assign GPRSel = `GPRSel_RD;
    wire _unused_funct7_bits = &{1'b0, Funct7[6], Funct7[4:0]};

    always @(*) begin
        RegWrite = 1'b0;
        MemWrite = 1'b0;
        EXTOp    = `EXT_CTRL_ITYPE;
        ALUOp    = `ALUOp_nop;
        NPCOp    = `NPC_PLUS4;
        ALUSrc   = 1'b0;
        WDSel    = `WDSel_FromALU;
        DMType   = `dm_word;

        case (Op)
            7'b0110011: begin // R-type
                RegWrite = 1'b1;
                case (Funct3)
                    3'b000: ALUOp = Funct7[5] ? `ALUOp_sub : `ALUOp_add;
                    3'b001: ALUOp = `ALUOp_sll;
                    3'b010: ALUOp = `ALUOp_slt;
                    3'b011: ALUOp = `ALUOp_sltu;
                    3'b100: ALUOp = `ALUOp_xor;
                    3'b101: ALUOp = Funct7[5] ? `ALUOp_sra : `ALUOp_srl;
                    3'b110: ALUOp = `ALUOp_or;
                    3'b111: ALUOp = `ALUOp_and;
                    default: ALUOp = `ALUOp_nop;
                endcase
            end

            7'b0010011: begin // I-type ALU
                RegWrite = 1'b1;
                ALUSrc   = 1'b1;
                case (Funct3)
                    3'b000: begin EXTOp = `EXT_CTRL_ITYPE;       ALUOp = `ALUOp_add;  end // addi
                    3'b001: begin EXTOp = `EXT_CTRL_ITYPE_SHAMT; ALUOp = `ALUOp_sll;  end // slli
                    3'b010: begin EXTOp = `EXT_CTRL_ITYPE;       ALUOp = `ALUOp_slt;  end // slti
                    3'b011: begin EXTOp = `EXT_CTRL_ITYPE;       ALUOp = `ALUOp_sltu; end // sltiu
                    3'b100: begin EXTOp = `EXT_CTRL_ITYPE;       ALUOp = `ALUOp_xor;  end // xori
                    3'b101: begin EXTOp = `EXT_CTRL_ITYPE_SHAMT; ALUOp = Funct7[5] ? `ALUOp_sra : `ALUOp_srl; end
                    3'b110: begin EXTOp = `EXT_CTRL_ITYPE;       ALUOp = `ALUOp_or;   end // ori
                    3'b111: begin EXTOp = `EXT_CTRL_ITYPE;       ALUOp = `ALUOp_and;  end // andi
                    default: begin EXTOp = `EXT_CTRL_ITYPE;      ALUOp = `ALUOp_nop;  end
                endcase
            end

            7'b0000011: begin // loads
                RegWrite = 1'b1;
                ALUSrc   = 1'b1;
                EXTOp    = `EXT_CTRL_ITYPE;
                ALUOp    = `ALUOp_add;
                WDSel    = `WDSel_FromMEM;
                case (Funct3)
                    3'b000: DMType = `dm_byte;
                    3'b001: DMType = `dm_halfword;
                    3'b010: DMType = `dm_word;
                    3'b100: DMType = `dm_byte_unsigned;
                    3'b101: DMType = `dm_halfword_unsigned;
                    default: DMType = `dm_word;
                endcase
            end

            7'b0100011: begin // stores
                MemWrite = 1'b1;
                ALUSrc   = 1'b1;
                EXTOp    = `EXT_CTRL_STYPE;
                ALUOp    = `ALUOp_add;
                case (Funct3)
                    3'b000: DMType = `dm_byte;
                    3'b001: DMType = `dm_halfword;
                    3'b010: DMType = `dm_word;
                    default: DMType = `dm_word;
                endcase
            end

            7'b1100011: begin // branches
                EXTOp  = `EXT_CTRL_BTYPE;
                NPCOp  = Zero ? `NPC_BRANCH : `NPC_PLUS4;
                case (Funct3)
                    3'b000: ALUOp = `ALUOp_sub;  // beq
                    3'b001: ALUOp = `ALUOp_bne;
                    3'b100: ALUOp = `ALUOp_blt;
                    3'b101: ALUOp = `ALUOp_bge;
                    3'b110: ALUOp = `ALUOp_bltu;
                    3'b111: ALUOp = `ALUOp_bgeu;
                    default: ALUOp = `ALUOp_nop;
                endcase
            end

            7'b1101111: begin // jal
                RegWrite = 1'b1;
                EXTOp    = `EXT_CTRL_JTYPE;
                NPCOp    = `NPC_JUMP;
                WDSel    = `WDSel_FromPC;
            end

            7'b1100111: begin // jalr
                RegWrite = 1'b1;
                ALUSrc   = 1'b1;
                EXTOp    = `EXT_CTRL_ITYPE;
                ALUOp    = `ALUOp_add;
                NPCOp    = `NPC_JALR;
                WDSel    = `WDSel_FromPC;
            end

            7'b0110111: begin // lui
                RegWrite = 1'b1;
                ALUSrc   = 1'b1;
                EXTOp    = `EXT_CTRL_UTYPE;
                ALUOp    = `ALUOp_lui;
            end

            7'b0010111: begin // auipc
                RegWrite = 1'b1;
                ALUSrc   = 1'b1;
                EXTOp    = `EXT_CTRL_UTYPE;
                ALUOp    = `ALUOp_auipc;
            end

            default: begin
                RegWrite = 1'b0;
                MemWrite = 1'b0;
            end
        endcase
    end
endmodule
