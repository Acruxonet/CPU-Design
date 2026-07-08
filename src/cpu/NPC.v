`timescale 1ns/1ps
`include "ctrl_encode_def.v"

module NPC(PC, NPCOp, IMM, NPC, aluout);
    input  wire [31:0] PC;
    input  wire [2:0]  NPCOp;
    input  wire [31:0] IMM;
    input  wire [31:0] aluout;
    output reg [31:0] NPC;
    wire _unused_aluout_bit0 = &{1'b0, aluout[0]};

    always @(*) begin
        case (NPCOp)
            `NPC_PLUS4:  NPC = PC + 32'd4;
            `NPC_BRANCH: NPC = PC + IMM;
            `NPC_JUMP:   NPC = PC + IMM;
            `NPC_JALR:   NPC = {aluout[31:1], 1'b0};
            default:     NPC = PC + 32'd4;
        endcase
    end
endmodule
