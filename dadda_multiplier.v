module dadda_multiplier (in1, in2, out);
	input [15:0] in1, in2;
	output [31:0] out;
	
	reg [31:0] pp [15:0];
	
	wire [31:0] lev_19 [15:0];		// Max 16 rows possible for 16 x 16 Dadda
	wire [31:0] lev_13 [12:0];
	wire [31:0] lev_9 [8:0];
	wire [31:0] lev_6 [5:0];
	wire [31:0] lev_4 [3:0];
	wire [31:0] lev_3 [2:0];
	wire [31:0] lev_2 [1:0];

	integer i;
	
	genvar k;
	generate
		for(k=0; k<16; k=k+1)
		begin: duplicate
			assign lev_19[k] = pp[k];
		end
	endgenerate
	
	always@(*)
	begin
		for (i=0; i<16; i=i+1)
		begin
			if (in2[i] == 1'b1)
				pp[i] = (in1 << i);
			else
				pp[i] = {2*16{1'b0}};	
		end
	end
	
	
//	Level-1: d=13

	generate
		for(k=0; k<13; k=k+1)
		begin: l1
			assign lev_13 [k] [12:0] = lev_19 [k] [12:0];
		end
	endgenerate
	
	half_adder l1_h1 (lev_19[0][13], lev_19[1][13], lev_13[0][13], lev_13[1][14]);
	
	full_adder l1_f1 (lev_19[0][14], lev_19[1][14], lev_13[2][14], lev_13[0][14], lev_13[1][15]);
	half_adder l1_h2 (lev_19[3][14], lev_19[4][14], lev_13[2][14], lev_13[3][15]);
	
	full_adder l1_f2 (lev_19[0][15], lev_19[1][15], lev_13[2][15], lev_13[0][15], lev_13[1][16]);
	full_adder l1_f3 (lev_19[3][15], lev_19[4][15], lev_13[5][15], lev_13[2][15], lev_13[3][16]);
	half_adder l1_h3 (lev_19[6][15], lev_19[7][15], lev_13[4][15], lev_13[5][16]);
	
	full_adder l1_f4 (lev_19[1][16], lev_19[2][16], lev_13[3][16], lev_13[0][16], lev_13[1][17]);
	full_adder l1_f5 (lev_19[4][16], lev_19[5][16], lev_13[6][16], lev_13[2][16], lev_13[3][17]);
	half_adder l1_h4 (lev_19[7][16], lev_19[8][16], lev_13[4][16], lev_13[5][17]);
	
	full_adder l1_f6 (lev_19[2][17], lev_19[3][17], lev_13[4][17], lev_13[0][17], lev_13[1][18]);
	full_adder l1_f7 (lev_19[5][17], lev_19[6][17], lev_13[7][17], lev_13[2][17], lev_13[3][18]);
	
	full_adder l1_f8 (lev_19[3][18], lev_19[4][18], lev_13[5][18], lev_13[0][18], lev_13[1][19]);
	
	generate
		for(k=6; k<13; k=k+1)
		begin: l2
			assign lev_13 [k] [18:15] = lev_19 [k+3] [18:15];
		end
	endgenerate		
	
	generate
		for(k=4; k<13; k=k+1)
		begin: l3
			assign lev_13 [k] [14:13] = lev_19 [k+1] [14:13];
		end
	endgenerate
	
	assign lev_13 [1] [13] = lev_19 [2] [13];
	assign lev_13 [2] [13] = lev_19 [3] [13];
	assign lev_13 [3] [13] = lev_19 [4] [13];

	assign lev_13 [3] [14] = lev_19 [14] [14];
	
	assign lev_13 [5] [15] = lev_19 [8] [15];
	
	assign lev_13 [4] [17] = lev_19 [8] [17];
	
	assign lev_13 [2] [18] = lev_19 [6] [18];
	assign lev_13 [4] [18] = lev_19 [7] [18];
	assign lev_13 [5] [18] = lev_19 [8] [18];	
	
	
	assign lev_13 [0] [19] = lev_19 [4] [19];
	generate
		for(k=2; k<13; k=k+1)
		begin: l4
			assign lev_13 [k] [31:19] = lev_19 [k+3] [31:19];
		end
	endgenerate	
	

//	Level-2: d=9
	generate
		for(k=0; k<9; k=k+1)
		begin: l5
			assign lev_9 [k] [8:0] = lev_13 [k] [8:0];
		end
	endgenerate
	
	half_adder l2_h1 (lev_13[0][9], lev_13[1][9], lev_9[0][9], lev_9[1][10]);
	
	full_adder l2_f1 (lev_13[0][10], lev_13[1][10], lev_13[2][10], lev_9[0][10], lev_9[1][11]);
	half_adder l2_h2 (lev_13[3][10], lev_13[4][10], lev_9[2][10], lev_9[3][11]);
	
	full_adder l2_f2 (lev_13[0][11], lev_13[1][11], lev_13[2][11], lev_9[0][11], lev_9[1][12]);
	full_adder l2_f3 (lev_13[3][11], lev_13[4][11], lev_13[5][11], lev_9[2][11], lev_9[3][12]);
	half_adder l2_h3 (lev_13[6][11], lev_13[7][11], lev_9[4][11], lev_9[5][12]);
	
	full_adder l2_f4 (lev_13[0][12], lev_13[1][12], lev_13[2][12], lev_9[0][12], lev_9[1][13]);
	full_adder l2_f5 (lev_13[3][12], lev_13[4][12], lev_13[5][12], lev_9[2][12], lev_9[3][13]);
	full_adder l2_f6 (lev_13[6][12], lev_13[7][12], lev_13[8][12], lev_9[4][12], lev_9[5][13]);
	half_adder l2_h4 (lev_13[9][12], lev_13[10][12], lev_9[6][12], lev_9[7][13]);
	
	full_adder l2_f7 (lev_13[0][13], lev_13[1][13], lev_13[2][13], lev_9[0][13], lev_9[1][14]);
	full_adder l2_f8 (lev_13[3][13], lev_13[4][13], lev_13[5][13], lev_9[2][13], lev_9[3][14]);
	full_adder l2_f9 (lev_13[6][13], lev_13[7][13], lev_13[8][13], lev_9[4][13], lev_9[5][14]);
	full_adder l2_f10 (lev_13[9][13], lev_13[10][13], lev_13[11][13], lev_9[6][13], lev_9[7][14]);
	
	full_adder l2_f11 (lev_13[0][14], lev_13[1][14], lev_13[2][14], lev_9[0][14], lev_9[1][15]);
	full_adder l2_f12 (lev_13[3][14], lev_13[4][14], lev_13[5][14], lev_9[2][14], lev_9[3][15]);
	full_adder l2_f13 (lev_13[6][14], lev_13[7][14], lev_13[8][14], lev_9[4][14], lev_9[5][15]);
	full_adder l2_f14 (lev_13[9][14], lev_13[10][14], lev_13[11][14], lev_9[6][14], lev_9[7][15]);
	
	full_adder l2_f15 (lev_13[0][15], lev_13[1][15], lev_13[2][15], lev_9[0][15], lev_9[1][16]);
	full_adder l2_f16 (lev_13[3][15], lev_13[4][15], lev_13[5][15], lev_9[2][15], lev_9[3][16]);
	full_adder l2_f17 (lev_13[6][15], lev_13[7][15], lev_13[8][15], lev_9[4][15], lev_9[5][16]);
	full_adder l2_f18 (lev_13[9][15], lev_13[10][15], lev_13[11][15], lev_9[6][15], lev_9[7][16]);
	
	full_adder l2_f19 (lev_13[0][16], lev_13[1][16], lev_13[2][16], lev_9[0][16], lev_9[1][17]);
	full_adder l2_f20 (lev_13[3][16], lev_13[4][16], lev_13[5][16], lev_9[2][16], lev_9[3][17]);
	full_adder l2_f21 (lev_13[6][16], lev_13[7][16], lev_13[8][16], lev_9[4][16], lev_9[5][17]);
	full_adder l2_f22 (lev_13[9][16], lev_13[10][16], lev_13[11][16], lev_9[6][16], lev_9[7][17]);
	
	full_adder l2_f23 (lev_13[0][17], lev_13[1][17], lev_13[2][17], lev_9[0][17], lev_9[1][18]);
	full_adder l2_f24 (lev_13[3][17], lev_13[4][17], lev_13[5][17], lev_9[2][17], lev_9[3][18]);
	full_adder l2_f25 (lev_13[6][17], lev_13[7][17], lev_13[8][17], lev_9[4][17], lev_9[5][18]);
	full_adder l2_f26 (lev_13[9][17], lev_13[10][17], lev_13[11][17], lev_9[6][17], lev_9[7][18]);
	
	full_adder l2_f27 (lev_13[0][18], lev_13[1][18], lev_13[2][18], lev_9[0][18], lev_9[1][19]);
	full_adder l2_f28 (lev_13[3][18], lev_13[4][18], lev_13[5][18], lev_9[2][18], lev_9[3][19]);
	full_adder l2_f29 (lev_13[6][18], lev_13[7][18], lev_13[8][18], lev_9[4][18], lev_9[5][19]);
	full_adder l2_f30 (lev_13[9][18], lev_13[10][18], lev_13[11][18], lev_9[6][18], lev_9[7][19]);
	
	full_adder l2_f31 (lev_13[0][19], lev_13[1][19], lev_13[2][19], lev_9[0][19], lev_9[1][20]);
	full_adder l2_f32 (lev_13[3][19], lev_13[4][19], lev_13[5][19], lev_9[2][19], lev_9[3][20]);
	full_adder l2_f33 (lev_13[6][19], lev_13[7][19], lev_13[8][19], lev_9[4][19], lev_9[5][20]);
	full_adder l2_f34 (lev_13[9][19], lev_13[10][19], lev_13[11][19], lev_9[6][19], lev_9[7][20]);
	
	full_adder l2_f35 (lev_13[2][20], lev_13[3][20], lev_13[4][20], lev_9[0][20], lev_9[1][21]);
	full_adder l2_f36 (lev_13[5][20], lev_13[6][20], lev_13[7][20], lev_9[2][20], lev_9[3][21]);
	full_adder l2_f37 (lev_13[8][20], lev_13[9][20], lev_13[10][20], lev_9[4][20], lev_9[5][21]);
	
	full_adder l2_f38 (lev_13[3][21], lev_13[4][21], lev_13[5][21], lev_9[0][21], lev_9[1][22]);
	full_adder l2_f39 (lev_13[6][21], lev_13[7][21], lev_13[8][21], lev_9[2][21], lev_9[3][22]);
	
	full_adder l2_f40 (lev_13[4][22], lev_13[5][22], lev_13[6][22], lev_9[0][22], lev_9[1][23]);
	
	generate
		for(k=1; k<9; k=k+1)
		begin: l6
			assign lev_9 [k] [9] = lev_13 [k+1] [9];
		end
	endgenerate
	
	generate
		for(k=3; k<9; k=k+1)
		begin: l7
			assign lev_9 [k] [10] = lev_13 [k+2] [10];
		end
	endgenerate
	
	generate
		for(k=5; k<9; k=k+1)
		begin: l8
			assign lev_9 [k] [11] = lev_13 [k+3] [11];
		end
	endgenerate
	
	assign lev_9 [7] [12] = lev_13 [11] [12];
	
	assign lev_9 [6] [20] = lev_13 [11] [20];
	
	generate
		for(k=6; k<8; k=k+1)
		begin: l9
			assign lev_9 [k] [21] = lev_13 [k+4] [21];
		end
	endgenerate
	
	assign lev_9 [4] [21] = lev_13 [9] [21];
	
	generate
		for(k=4; k<8; k=k+1)
		begin: l10
			assign lev_9 [k] [22] = lev_13 [k+4] [22];
		end
	endgenerate
	
	assign lev_9 [2] [22] = lev_13 [7] [22];
	
	assign lev_9 [8] [22:12] = lev_13 [12] [22:12];
	
	assign lev_9 [0] [23] = lev_13 [5] [23];
	generate
		for(k=2; k<9; k=k+1)
		begin: l11
			assign lev_9 [k] [31:23] = lev_13 [k+4] [31:23];
		end
	endgenerate	
	
	
//	Level-3: d=6
	generate
		for(k=0; k<6; k=k+1)
		begin: l12
			assign lev_6 [k] [5:0] = lev_9 [k] [5:0];
		end
	endgenerate	
	
	generate
		for(k=1; k<6; k=k+1)
		begin: l13
			assign lev_6 [k] [6] = lev_9 [k+1] [6];
		end
	endgenerate	

	generate
		for(k=3; k<6; k=k+1)
		begin: l14
			assign lev_6 [k] [7] = lev_9 [k+2] [7];
		end
	endgenerate	
	
	assign lev_6 [5] [8] = lev_9 [8] [8];
	
	half_adder l3_h1 (lev_9[0][6], lev_9[1][6], lev_6[0][6], lev_6[1][7]);
	
	full_adder l3_f1 (lev_9[0][7], lev_9[1][7], lev_9[2][7], lev_6[0][7], lev_6[1][8]);
	half_adder l3_h2 (lev_9[3][7], lev_9[4][7], lev_6[2][7], lev_6[3][8]);
	
	full_adder l3_f2 (lev_9[0][8], lev_9[1][8], lev_9[2][8], lev_6[0][8], lev_6[1][9]);
	full_adder l3_f3 (lev_9[3][8], lev_9[4][8], lev_9[5][8], lev_6[2][8], lev_6[3][9]);
	half_adder l3_h3 (lev_9[6][8], lev_9[7][8], lev_6[4][8], lev_6[5][9]);
	
	generate
		for(k=9; k<24; k=k+1)
		begin: FA_1
			full_adder l3_1 (lev_9[0][k], lev_9[1][k], lev_9[2][k], lev_6[0][k], lev_6[1][k+1]);
			full_adder l3_2 (lev_9[3][k], lev_9[4][k], lev_9[5][k], lev_6[2][k], lev_6[3][k+1]);
			full_adder l3_3 (lev_9[6][k], lev_9[7][k], lev_9[8][k], lev_6[4][k], lev_6[5][k+1]);
		end
	endgenerate
	
	assign lev_6 [4] [24] = lev_9 [8] [24];
	
	assign lev_6 [2] [25] = lev_9 [6] [25];
	assign lev_6 [4] [25] = lev_9 [7] [25];
	assign lev_6 [5] [25] = lev_9 [8] [25];
	
	assign lev_6 [0] [26] = lev_9 [4] [26];

	full_adder l3_f4 (lev_9[2][24], lev_9[3][24], lev_9[4][24], lev_6[0][24], lev_6[1][25]);
	full_adder l3_f5 (lev_9[5][24], lev_9[6][24], lev_9[7][24], lev_6[2][24], lev_6[3][25]);
	
	full_adder l3_f6 (lev_9[3][25], lev_9[4][25], lev_9[5][25], lev_6[0][25], lev_6[1][26]);
	
	
	
	generate
		for(k=2; k<6; k=k+1)
		begin: l15
			assign lev_6 [k] [31:26] = lev_9 [k+3] [31:26];
		end
	endgenerate		
	
	
//	Level-4: d=4
	generate
		for(k=0; k<4; k=k+1)
		begin: l16
			assign lev_4 [k] [3:0] = lev_6 [k] [3:0];
		end
	endgenerate	

	generate
		for(k=1; k<4; k=k+1)
		begin: l17
			assign lev_4 [k] [4] = lev_6 [k+1] [4];
		end
	endgenerate	
	
	assign lev_4 [3] [5] = lev_6 [5] [5];
	
	half_adder l4_h1 (lev_6[0][4], lev_6[1][4], lev_4[0][4], lev_4[1][5]);
		
	full_adder l4_f1 (lev_6[0][5], lev_6[1][5], lev_6[2][5], lev_4[0][5], lev_4[1][6]);
	half_adder l4_h2 (lev_6[3][5], lev_6[4][5], lev_4[2][5], lev_4[3][6]);
	
	generate
		for(k=6; k<27; k=k+1)
		begin: FA_2
			full_adder l4_1 (lev_6[0][k], lev_6[1][k], lev_6[2][k], lev_4[0][k], lev_4[1][k+1]);
			full_adder l4_2 (lev_6[3][k], lev_6[4][k], lev_6[5][k], lev_4[2][k], lev_4[3][k+1]);
		end
	endgenerate
	
	full_adder l4_f2 (lev_6[2][27], lev_6[3][27], lev_6[4][27], lev_4[0][27], lev_4[1][28]);
	
	assign lev_4 [2] [27] = lev_6 [5] [27];
	
	assign lev_4 [0] [28] = lev_6 [3] [28];
	
	generate
		for(k=2; k<4; k=k+1)
		begin: l18
			assign lev_4 [k] [31:28] = lev_6 [k+2] [31:28];
		end
	endgenerate			
	
//	Level-5: d=3
	generate
		for(k=0; k<3; k=k+1)
		begin: l19
			assign lev_3 [k] [2:0] = lev_4 [k] [2:0];
		end
	endgenerate
	
	half_adder l5_h1 (lev_4[0][3], lev_4[1][3], lev_3[0][3], lev_3[1][4]);
	assign lev_3 [1] [3] = lev_4 [2] [3];
		
	generate
		for(k=4; k<29; k=k+1)
		begin: FA_3
			full_adder l5_f1 (lev_4[0][k], lev_4[1][k], lev_4[2][k], lev_3[0][k], lev_3[1][k+1]);
		end
	endgenerate	
	
	assign lev_3 [0] [29] = lev_4 [2] [29];
	
	assign lev_3 [2] [31:3] = lev_4 [3] [31:3];
	
//	Level-6: d=2
	generate
		for(k=0; k<2; k=k+1)
		begin: l20
			assign lev_2 [k] [1:0] = lev_3 [k] [1:0];
		end
	endgenerate	
	
	
	half_adder l6_h1 (lev_3[0][2], lev_3[1][2], lev_2[0][2], lev_2[1][3]);
	assign lev_2 [1] [2] = lev_3 [2] [2];
	
	generate
		for(k=3; k<30; k=k+1)
		begin: FA_4
			full_adder l6_f1 (lev_3[0][k], lev_3[1][k], lev_3[2][k], lev_2[0][k], lev_2[1][k+1]);
		end
	endgenerate	
	
	assign lev_2 [0] [30] = lev_3 [2] [30];
	
	assign lev_2 [0] [31] = 1'b0;
	assign lev_2 [1] [31] = 1'b0;
	
	
// brent_kung_adder bka ( lev_2[0], lev_2[1], 0, out);
	assign out = lev_2[0] + lev_2[1];
	
endmodule

module half_adder(input x,y,
				  output s,c);
		
assign s = ( x ^ y );
assign c = ( x & y );
		
endmodule

module full_adder(input z,w,u,
				  output sum,cout);
		

assign sum  = ( z ^ w ^ u );
assign cout = ( z & w ) | ( w & u ) | ( u & z );
		
endmodule


module tb;

    // Inputs
    reg [15:0] A;
    reg [15:0] B;

    // Outputs
    wire [31:0] Prod;
    integer i,j,error;

    // Instantiate the Unit Under Test (UUT)
    dadda_multiplier uut (.in1(A), .in2(B), .out(Prod));

    initial begin
        // Apply inputs for the whole range of A and B.
        // 16*16 = 256 inputs.
        error = 0;
        for(i=0;i <=100;i = i+1)
            for(j=0;j <=100;j = j+1) 
            begin
                A <= i; 
                B <= j;
                #1;
                if(Prod != A*B) //if the result isnt correct increment "error".
                    error = error + 1;  
            end     
    end
      
endmodule