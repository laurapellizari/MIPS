module Control(
	input [31:0] in,
	output [22:0] out
);

	wire [5:0] code_op, op;
	wire [4:0] rs,rt;
	reg [1:0] sel_ALU;
	reg mul_st;
	reg alu1_mux;
	reg alu2_mux;
	reg mem_wr;
	reg mux_sel_wb;
	reg [4:0] rd;
	reg leprin_escprin;
	
	 assign code_op = in[31:26];
	 assign rs = in[25:21];
	 assign rt = in[20:16];
	 assign op = in[5:0];
  
   	
	assign out = {rs, rt, rd, leprin_escprin, alu1_mux, sel_ALU, mul_st,  alu2_mux, mem_wr, mux_sel_wb};


	always @ (in) 
	begin
	
		case(code_op)
			5'd5: 				
			begin
				rd = rt;           
				leprin_escprin = 1;              
				alu1_mux = 1;
				sel_ALU = 2'b0;
				mul_st = 0;
				alu2_mux = 1;
				mem_wr = 0;        
				mux_sel_wb = 1;
			end
			
			5'd6: 				 
			begin
				rd = rt;
				leprin_escprin = 0;
				alu1_mux = 1;
				sel_ALU = 2'b0;     
				mul_st = 0;         
				alu2_mux = 1;       
				mem_wr = 1;               
				mux_sel_wb = 1; 
			end
			
			5'd4: 						 
			begin  
				rd = in[15:11]; 
				leprin_escprin = 1;               
				alu1_mux = 0;          
				mul_st = 0;
				mem_wr = 0;
				mux_sel_wb = 0;
				
				case(op)
					6'd32:  
					begin 
						sel_ALU = 2'b0;
						alu2_mux = 1; 
					end
					
					6'd34: 
					begin
						sel_ALU = 2'b1;
						alu2_mux = 1; 
					end
					
					6'd50: 
					begin
						sel_ALU = 2'b0;
						mul_st = 1;
						alu2_mux = 0;  
					end
					
					6'd36: 
					begin
						sel_ALU = 2'b10;
						alu2_mux = 1; 
					end
					
					6'd37: 
					begin
						sel_ALU = 2'b11;
						alu2_mux = 1; 
					end
					
					default:
					begin
						sel_ALU = 2'b0;
						alu2_mux = 1;
					end
					
				endcase
			end
			
			default: 
			begin
				rd = 5'b0;
				leprin_escprin = 0;
				alu1_mux = 0;
				sel_ALU = 0;
				mul_st = 0;
				alu2_mux = 1;
				mem_wr = 0;
				mux_sel_wb = 0;				
			end
			
		endcase
	end

endmodule 