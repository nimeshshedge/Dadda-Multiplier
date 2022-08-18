module dadda (
	input [15:0] a, b,
	output[31:0] prod_final);
	
	wire [15:0] pp0; //Row0
	wire [16:1] pp1; //Row1
	wire [17:2] pp2; //Row2
	wire [18:3] pp3; //Row3
	wire [19:4] pp4; //Row4
	wire [20:5] pp5; //Row5
	wire [21:6] pp6; //Row6
	wire [22:7] pp7; //Row7
	wire [23:8] pp8; //Row8
	wire [24:9] pp9; //Row9
	wire [25:10] pp10; //Row10
	wire [26:11] pp11; //Row11
	wire [27:12] pp12; //Row12
	wire [28:13] pp13; //Row13
	wire [29:14] pp14; //Row14
	wire [30:15] pp15; //Row15
	
	genvar i;
	generate 
		for(i=0;i<16;i=i+1) begin
			assign pp0[i] = a[i] & b[0];
			assign pp1[i+1] = a[i] & b[1];
			assign pp2[i+2] = a[i] & b[2];
			assign pp3[i+3] = a[i] & b[3];
			assign pp4[i+4] = a[i] & b[4];
			assign pp5[i+5] = a[i] & b[5];
			assign pp6[i+6] = a[i] & b[6];
			assign pp7[i+7] = a[i] & b[7];
			assign pp8[i+8] = a[i] & b[8];
			assign pp9[i+9] = a[i] & b[9];
			assign pp10[i+10] = a[i] & b[10];
			assign pp11[i+11] = a[i] & b[11];
			assign pp12[i+12] = a[i] & b[12];
			assign pp13[i+13] = a[i] & b[13];
			assign pp14[i+14] = a[i] & b[14];
			assign pp15[i+15] = a[i] & b[15];
		end
	endgenerate
	
	//level6
	//wires
	wire [18:13] l6_pp0;
	wire [19:14] l6_pp1;
	wire [17:14] l6_pp2;
	wire [18:15] l6_pp3;
	wire [16:15] l6_pp4;
	wire [17:16] l6_pp5;
	
	ha l6_ha1(pp0[13], pp1[13], l6_pp0[13], l6_pp1[14]);
	
	fa l6_fa1(pp0[14], pp1[14], pp2[14], l6_pp0[14], l6_pp1[15]);
	ha l6_ha2(pp3[14], pp4[14], l6_pp2[14], l6_pp3[15]);
	
	fa l6_fa2(pp0[15], pp1[15], pp2[15], l6_pp0[15], l6_pp1[16]);
	fa l6_fa3(pp3[15], pp4[15], pp5[15], l6_pp2[15], l6_pp3[16]);
	ha l6_ha3(pp6[15], pp7[15], l6_pp4[15], l6_pp5[16]);
	
	fa l6_fa4(pp1[16], pp2[16], pp3[16], l6_pp0[16], l6_pp1[17]);
	fa l6_fa5(pp4[16], pp5[16], pp6[16], l6_pp2[16], l6_pp3[17]);
	ha l6_ha4(pp7[16], pp8[16], l6_pp4[16], l6_pp5[17]);
	
	fa l6_fa6(pp2[17], pp3[17], pp4[17], l6_pp0[17], l6_pp1[18]);
	fa l6_fa7(pp5[17], pp6[17], pp7[17], l6_pp2[17], l6_pp3[18]);
	
	fa l6_fa8(pp3[18], pp4[18], pp5[18], l6_pp0[18], l6_pp1[19]);
	
	//level5
	//wires
	wire [22:9] l5_pp0;
	wire [23:10] l5_pp1;
	wire [21:10] l5_pp2;
	wire [22:11] l5_pp3;
	wire [20:11] l5_pp4;
	wire [21:12] l5_pp5;
	wire [19:12] l5_pp6;
	wire [20:13] l5_pp7;
	
	ha l5_ha1(pp0[9], pp1[9], l5_pp0[9], l5_pp1[10]);
	
	fa l5_fa1(pp0[10], pp1[10], pp2[10], l5_pp0[10], l5_pp1[11]);
	ha l5_ha2(pp3[10], pp4[10], l5_pp2[10], l5_pp3[11]);
	
	fa l5_fa2(pp0[11], pp1[11], pp2[11], l5_pp0[11], l5_pp1[12]);
	fa l5_fa3(pp3[11], pp4[11], pp5[11], l5_pp2[11], l5_pp3[12]);
	ha l5_ha3(pp6[11], pp7[11], l5_pp4[11], l5_pp5[12]);
	
	fa l5_fa4(pp0[12], pp1[12], pp2[12], l5_pp0[12], l5_pp1[13]);
	fa l5_fa5(pp3[12], pp4[12], pp5[12], l5_pp2[12], l5_pp3[13]);
	fa l5_fa6(pp6[12], pp7[12], pp8[12], l5_pp4[12], l5_pp5[13]);
	ha l5_ha4(pp9[12], pp10[12], l5_pp6[12], l5_pp7[13]);
	
	fa l5_fa7(l6_pp0[13], pp2[13], pp3[13], l5_pp0[13], l5_pp1[14]);
	fa l5_fa8(pp4[13], pp5[13], pp6[13], l5_pp2[13], l5_pp3[14]);
	fa l5_fa9(pp7[13], pp8[13], pp9[13], l5_pp4[13], l5_pp5[14]);
	fa l5_fa10(pp10[13], pp11[13], pp12[13], l5_pp6[13], l5_pp7[14]);
	
	fa l5_fa11(l6_pp0[14],l6_pp1[14], l6_pp2[14], l5_pp0[14], l5_pp1[15]);
	fa l5_fa12(pp5[14], pp6[14], pp7[14], l5_pp2[14], l5_pp3[15]);
	fa l5_fa13(pp8[14], pp9[14], pp10[14], l5_pp4[14], l5_pp5[15]);
	fa l5_fa14(pp11[14], pp12[14], pp13[14], l5_pp6[14], l5_pp7[15]);
	
	fa l5_fa15(l6_pp0[15],l6_pp1[15], l6_pp2[15], l5_pp0[15], l5_pp1[16]);
	fa l5_fa16(l6_pp3[15], l6_pp4[15], pp8[15], l5_pp2[15], l5_pp3[16]);
	fa l5_fa17(pp9[15], pp10[15], pp11[15], l5_pp4[15], l5_pp5[16]);
	fa l5_fa18(pp12[15], pp13[15], pp14[15], l5_pp6[15], l5_pp7[16]);
	
	fa l5_fa19(l6_pp0[16],l6_pp1[16], l6_pp2[16], l5_pp0[16], l5_pp1[17]);
	fa l5_fa20(l6_pp3[16], l6_pp4[16], l6_pp5[16], l5_pp2[16], l5_pp3[17]);
	fa l5_fa21(pp9[16], pp10[16], pp11[16], l5_pp4[16], l5_pp5[17]);
	fa l5_fa22(pp12[16], pp13[16], pp14[16], l5_pp6[16], l5_pp7[17]);
	
	fa l5_fa23(l6_pp0[17],l6_pp1[17], l6_pp2[17], l5_pp0[17], l5_pp1[18]);
	fa l5_fa24(l6_pp3[17], pp8[17], l6_pp5[17], l5_pp2[17], l5_pp3[18]);
	fa l5_fa25(pp9[17], pp10[17], pp11[17], l5_pp4[17], l5_pp5[18]);
	fa l5_fa26(pp12[17], pp13[17], pp14[17], l5_pp6[17], l5_pp7[18]);
	
	fa l5_fa27(l6_pp0[18],l6_pp1[18], pp6[18], l5_pp0[18], l5_pp1[19]);
	fa l5_fa28(l6_pp3[18], pp7[18], pp8[18], l5_pp2[18], l5_pp3[19]);
	fa l5_fa29(pp9[18], pp10[18], pp11[18], l5_pp4[18], l5_pp5[19]);
	fa l5_fa30(pp12[18], pp13[18], pp14[18], l5_pp6[18], l5_pp7[19]);
	
	fa l5_fa31(pp4[19],l6_pp1[19], pp5[19], l5_pp0[19], l5_pp1[20]);
	fa l5_fa32(pp6[19], pp7[19], pp8[19], l5_pp2[19], l5_pp3[20]);
	fa l5_fa33(pp9[19], pp10[19], pp11[19], l5_pp4[19], l5_pp5[20]);
	fa l5_fa34(pp12[19], pp13[19], pp14[19], l5_pp6[19], l5_pp7[20]);
	
	fa l5_fa35(pp5[20], pp6[20], pp7[20], l5_pp0[20], l5_pp1[21]);
	fa l5_fa36(pp8[20], pp9[20], pp10[20], l5_pp2[20], l5_pp3[21]);
	fa l5_fa37(pp11[20], pp12[20], pp13[20], l5_pp4[20], l5_pp5[21]);
	
	fa l5_fa38(pp6[21], pp7[21], pp8[21], l5_pp0[21], l5_pp1[22]);
	fa l5_fa39(pp9[21], pp10[21], pp11[21], l5_pp2[21], l5_pp3[22]);
	
	fa l5_fa40(pp7[22], pp8[22], pp9[22], l5_pp0[22], l5_pp1[23]);
	
	//level4
	//wires
	wire [25:6] l4_pp0;
	wire [26:7] l4_pp1;
	wire [24:7] l4_pp2;
	wire [25:8] l4_pp3;
	wire [23:8] l4_pp4;
	wire [24:9] l4_pp5;
	
	ha l4_ha1(pp0[6], pp1[6], l4_pp0[6], l4_pp1[7]);
	
	fa l4_fa1(pp0[7], pp1[7], pp2[7], l4_pp0[7], l4_pp1[8]);
	ha l4_ha2(pp3[7], pp4[7], l4_pp2[7], l4_pp3[8]);
	
	fa l4_fa2(pp0[8], pp1[8], pp2[8], l4_pp0[8], l4_pp1[9]);
	fa l4_fa3(pp3[8], pp4[8], pp5[8], l4_pp2[8], l4_pp3[9]);
	ha l4_ha3(pp6[8], pp7[8], l4_pp4[8], l4_pp5[9]);
	
	fa l4_fa4(l5_pp0[9], pp2[9], pp3[9], l4_pp0[9], l4_pp1[10]);
	fa l4_fa5(pp4[9], pp5[9], pp6[9], l4_pp2[9], l4_pp3[10]);
	fa l4_fa6(pp7[9], pp8[9], pp9[9], l4_pp4[9], l4_pp5[10]);
	
	fa l4_fa7(l5_pp0[10], l5_pp1[10], l5_pp2[10], l4_pp0[10], l4_pp1[11]);
	fa l4_fa8(pp5[10], pp6[10], pp7[10], l4_pp2[10], l4_pp3[11]);
	fa l4_fa9(pp8[10], pp9[10], pp10[10], l4_pp4[10], l4_pp5[11]);
	
	fa l4_fa10(l5_pp0[11], l5_pp1[11], l5_pp2[11], l4_pp0[11], l4_pp1[12]);
	fa l4_fa11(l5_pp3[11], l5_pp4[11], pp8[11], l4_pp2[11], l4_pp3[12]);
	fa l4_fa12(pp9[11], pp10[11], pp11[11], l4_pp4[11], l4_pp5[12]);
	
	fa l4_fa13(l5_pp0[12], l5_pp1[12], l5_pp2[12], l4_pp0[12], l4_pp1[13]);
	fa l4_fa14(l5_pp3[12], l5_pp4[12], l5_pp5[12], l4_pp2[12], l4_pp3[13]);
	fa l4_fa15(l5_pp6[12], pp11[12], pp12[12], l4_pp4[12], l4_pp5[13]);
	
	fa l4_fa16(l5_pp0[13], l5_pp1[13], l5_pp2[13], l4_pp0[13], l4_pp1[14]);
	fa l4_fa17(l5_pp3[13], l5_pp4[13], l5_pp5[13], l4_pp2[13], l4_pp3[14]);
	fa l4_fa18(l5_pp6[13], l5_pp7[13], pp13[13], l4_pp4[13], l4_pp5[14]);
	
	fa l4_fa52(l5_pp0[14], l5_pp1[14], l5_pp2[14], l4_pp0[14], l4_pp1[15]);
	fa l4_fa53(l5_pp3[14], l5_pp4[14], l5_pp5[14], l4_pp2[14], l4_pp3[15]);
	fa l4_fa54(l5_pp6[14], l5_pp7[14], pp14[14], l4_pp4[14], l4_pp5[15]);
	
	fa l4_fa22(l5_pp0[15], l5_pp1[15], l5_pp2[15], l4_pp0[15], l4_pp1[16]);
	fa l4_fa23(l5_pp3[15], l5_pp4[15], l5_pp5[15], l4_pp2[15], l4_pp3[16]);
	fa l4_fa24(l5_pp6[15], l5_pp7[15], pp15[15], l4_pp4[15], l4_pp5[16]);
	
	fa l4_fa25(l5_pp0[16], l5_pp1[16], l5_pp2[16], l4_pp0[16], l4_pp1[17]);
	fa l4_fa26(l5_pp3[16], l5_pp4[16], l5_pp5[16], l4_pp2[16], l4_pp3[17]);
	fa l4_fa27(l5_pp6[16], l5_pp7[16], pp15[16], l4_pp4[16], l4_pp5[17]);
	
	fa l4_fa28(l5_pp0[17], l5_pp1[17], l5_pp2[17], l4_pp0[17], l4_pp1[18]);
	fa l4_fa29(l5_pp3[17], l5_pp4[17], l5_pp5[17], l4_pp2[17], l4_pp3[18]);
	fa l4_fa30(l5_pp6[17], l5_pp7[17], pp15[17], l4_pp4[17], l4_pp5[18]);
	
	fa l4_fa31(l5_pp0[18], l5_pp1[18], l5_pp2[18], l4_pp0[18], l4_pp1[19]);
	fa l4_fa32(l5_pp3[18], l5_pp4[18], l5_pp5[18], l4_pp2[18], l4_pp3[19]);
	fa l4_fa33(l5_pp6[18], l5_pp7[18], pp15[18], l4_pp4[18], l4_pp5[19]);
	
	fa l4_fa34(l5_pp0[19], l5_pp1[19], l5_pp2[19], l4_pp0[19], l4_pp1[20]);
	fa l4_fa35(l5_pp3[19], l5_pp4[19], l5_pp5[19], l4_pp2[19], l4_pp3[20]);
	fa l4_fa36(l5_pp6[19], l5_pp7[19], pp15[19], l4_pp4[19], l4_pp5[20]);
	
	fa l4_fa37(l5_pp0[20], l5_pp1[20], l5_pp2[20], l4_pp0[20], l4_pp1[21]);
	fa l4_fa38(l5_pp3[20], l5_pp4[20], l5_pp5[20], l4_pp2[20], l4_pp3[21]);
	fa l4_fa39(pp14[20], l5_pp7[20], pp15[20], l4_pp4[20], l4_pp5[21]);
	
	fa l4_fa40(l5_pp0[21], l5_pp1[21], l5_pp2[21], l4_pp0[21], l4_pp1[22]);
	fa l4_fa41(l5_pp3[21], pp12[21], l5_pp5[21], l4_pp2[21], l4_pp3[22]);
	fa l4_fa42(pp13[21], pp14[21], pp15[21], l4_pp4[21], l4_pp5[22]);
	
	fa l4_fa43(l5_pp0[22], l5_pp1[22], pp10[22], l4_pp0[22], l4_pp1[23]);
	fa l4_fa44(l5_pp3[22], pp11[22], pp12[22], l4_pp2[22], l4_pp3[23]);
	fa l4_fa45(pp13[22], pp14[22], pp15[22], l4_pp4[22], l4_pp5[23]);
	
	fa l4_fa46(pp8[23], l5_pp1[23], pp9[23], l4_pp0[23], l4_pp1[24]);
	fa l4_fa47(pp10[23], pp11[23], pp12[23], l4_pp2[23], l4_pp3[24]);
	fa l4_fa48(pp13[23], pp14[23], pp15[23], l4_pp4[23], l4_pp5[24]);
	
	fa l4_fa49(pp9[24], pp10[24], pp11[24], l4_pp0[24], l4_pp1[25]);
	fa l4_fa50(pp12[24], pp13[24], pp14[24], l4_pp2[24], l4_pp3[25]);
	
	fa l4_fa51(pp10[25], pp11[25], pp12[25], l4_pp0[25], l4_pp1[26]);
	
	//level 3
	//wires
	wire [27:4] l3_pp0;
	wire [28:5] l3_pp1;
	wire [26:5] l3_pp2;
	wire [27:6] l3_pp3;
	
	ha l3_ha1(pp0[4], pp1[4], l3_pp0[4], l3_pp1[5]);
	
	fa l3_fa1(pp0[5], pp1[5], pp2[5], l3_pp0[5], l3_pp1[6]);
	ha l3_ha2(pp3[5], pp4[5], l3_pp2[5], l3_pp3[6]);
	
	fa l3_fa2(l4_pp0[6], pp2[6], pp3[6], l3_pp0[6], l3_pp1[7]);
	fa l3_fa3(pp4[6], pp5[6], pp6[6], l3_pp2[6], l3_pp3[7]);
	
	fa l3_fa4(l4_pp0[7], l4_pp1[7], l4_pp2[7], l3_pp0[7], l3_pp1[8]);
	fa l3_fa5(pp5[7], pp6[7], pp7[7], l3_pp2[7], l3_pp3[8]);
	
	fa l3_fa6(l4_pp0[8], l4_pp1[8], l4_pp2[8], l3_pp0[8], l3_pp1[9]);
	fa l3_fa7(l4_pp3[8], l4_pp4[8], pp8[8], l3_pp2[8], l3_pp3[9]);
	
	genvar j;
	generate
		for (j=9;j<24;j=j+1) begin : level3
			fa l3_fa1a(l4_pp0[j], l4_pp1[j], l4_pp2[j], l3_pp0[j], l3_pp1[j+1]);
			fa l3_fa1b(l4_pp3[j], l4_pp4[j], l4_pp5[j], l3_pp2[j], l3_pp3[j+1]);
		end
	endgenerate
	
	fa l3_fa8(l4_pp0[24], l4_pp1[24], l4_pp2[24], l3_pp0[24], l3_pp1[25]);
	fa l3_fa9(l4_pp3[24], pp15[24], l4_pp5[24], l3_pp2[24], l3_pp3[25]);
	
	fa l3_fa10(l4_pp0[25], l4_pp1[25], pp13[24], l3_pp0[25], l3_pp1[26]);
	fa l3_fa11(l4_pp3[25], pp14[25], pp15[25], l3_pp2[25], l3_pp3[26]);
	
	fa l3_fa12(pp11[26], l4_pp1[26], pp12[26], l3_pp0[26], l3_pp1[27]);
	fa l3_fa13(pp13[26], pp14[26], pp15[26], l3_pp2[26], l3_pp3[27]);
	
	fa l3_fa14(pp12[27], pp13[27], pp14[27], l3_pp0[27], l3_pp1[28]);
	
	//level 2
	//wires
	wire [28:3] l2_pp0;
	wire [29:4] l2_pp1;
	
	ha l2_ha1(pp0[3], pp1[3], l2_pp0[3], l2_pp1[4]);
	
	fa l2_fa1(l3_pp0[4], pp2[4], pp3[4], l2_pp0[4], l2_pp1[5]);
	
	genvar k;
	generate 
		for(k=5;k<27;k=k+1) begin : level2
			fa l2_fa(l3_pp0[k], l3_pp1[k], l3_pp2[k], l2_pp0[k], l2_pp1[k+1]);
		end
	endgenerate
	
	fa l2_fa2(l3_pp0[27], l3_pp1[27], pp15[27], l2_pp0[27], l2_pp1[28]);
	
	fa l2_fa3(pp13[28], l3_pp1[28], pp14[28], l2_pp0[28], l2_pp1[29]);
	
	//level 1
	//wires
	wire [31:0] l1_pp0;
	wire [31:0] l1_pp1;
	
	assign l1_pp0[0] = pp0[0];
	assign l1_pp1[0] = 1'b0;
	assign l1_pp0[1] = pp0[1];
	assign l1_pp1[1] = pp1[1];
	assign l1_pp1[2] = pp2[2];
	
	ha l1_ha1(pp0[2], pp1[2], l1_pp0[2], l1_pp1[3]);
	
	fa l1_fa1(l2_pp0[3], pp2[3], pp3[3], l1_pp0[3], l1_pp1[4]);
	
	fa l1_fa2(l2_pp0[4], l2_pp1[4], pp4[4], l1_pp0[4], l1_pp1[5]);
	
	fa l1_fa3(l2_pp0[5], l2_pp1[5], pp5[5], l1_pp0[5], l1_pp1[6]);
	
	genvar l;
	generate 
		for(l=6;l<28;l=l+1) begin : level1
			fa l1_fa(l2_pp0[l], l2_pp1[l], l3_pp3[l], l1_pp0[l], l1_pp1[l+1]);
		end
	endgenerate
	
	fa l1_fa4(l2_pp0[28], l2_pp1[28], pp15[28], l1_pp0[28], l1_pp1[29]);
	
	fa l1_fa5(pp14[29], l2_pp1[29], pp15[29], l1_pp0[29], l1_pp1[30]);
	
	assign l1_pp0[30] = pp15[30];
	assign l1_pp0[31] = 1'b0;
	assign l1_pp1[31] = 1'b0;
	
	//final addition
	//assign prod_final = l1_pp0[30:0] + l1_pp1[30:0];
	wire ignore_carry;
	BK_adder32bit adder1 (l1_pp0,l1_pp1,1'b0, prod_final,ignore_carry);
	
endmodule

module fa (
	input a, b, cin,
	output sum, carry);
	
	assign sum = a ^ b ^ cin;
	assign carry = (a&b)|(b&cin)|(a&cin);
endmodule

module ha (
	input a, b,
	output sum, carry);
	
	assign sum = a ^ b;
	assign carry = a & b;
endmodule

module BK_adder32bit (
	input [31:0]x, y,
	input cin,
	output [31:0] sum,
	output cout);
	
	wire [32:0] carry;
	assign carry[0] = cin; //input carry
	
	wire [31:0] G_1, P_1;
	assign G_1 = x & y;
	assign P_1 = x ^ y;
	
	//level1
	genvar i;
	wire [15:0] G_2, P_2;
	generate
		for(i=0;i<16;i=i+1) begin
			assign G_2[i] = G_1[2*i+1] | P_1[2*i+1] & G_1[2*i];
			assign P_2[i] = P_1[2*i+1] & P_1[2*i];
		end
	endgenerate
	
	//level2
	genvar j;
	wire [7:0] G_3, P_3;
	generate
		for(j=0;j<8;j=j+1) begin
			assign G_3[j] = G_2[2*j+1] | P_2[2*j+1] & G_2[2*j];
			assign P_3[j] = P_2[2*j+1] & P_2[2*j];
		end
	endgenerate
	
	//level3
	genvar k;
	wire [3:0] G_4, P_4;
	generate
		for(k=0;k<4;k=k+1) begin
			assign G_4[k] = G_3[2*k+1] | P_3[2*k+1] & G_3[2*k];
			assign P_4[k] = P_3[2*k+1] & P_3[2*k];
		end
	endgenerate
	
	//level4
	genvar l;
	wire [1:0] G_5, P_5;
	generate
		for(l=0;l<2;l=l+1) begin
			assign G_5[l] = G_4[2*l+1] | P_4[2*l+1] & G_4[2*l];
			assign P_5[l] = P_4[2*l+1] & P_4[2*l];
		end
	endgenerate
	
	//level5
	wire G_6, P_6;
	assign G_6 = G_5[1] | P_5[1] & G_5[0];
	assign P_6 = P_5[1] & P_5[0];
	
	//carry generation
	//1st iteration
	assign carry[32] = G_6 | P_6 & carry[0];
	assign carry[16] = G_5[0] | P_5[0] & carry[0];
	
	//2nd iteration
	assign carry[8] = G_4[0] | P_4[0] & carry[0];
	assign carry[24] = G_4[2] | P_4[2] & carry[16];
	
	//3rd iteration
	assign carry[4] = G_3[0] | P_3[0] & carry[0];
	assign carry[12] = G_3[2] | P_3[2] & carry[8];
	assign carry[20] = G_3[4] | P_3[4] & carry[16];
	assign carry[28] = G_3[6] | P_3[6] & carry[24];
	
	//4th iteration
	assign carry[2] = G_2[0] | P_2[0] & carry[0];
	assign carry[6] = G_2[2] | P_2[2] & carry[4];
	assign carry[10] = G_2[4] | P_2[4] & carry[8];
	assign carry[14] = G_2[6] | P_2[6] & carry[12];
	assign carry[18] = G_2[8] | P_2[8] & carry[16];
	assign carry[22] = G_2[10] | P_2[10] & carry[20];
	assign carry[26] = G_2[12] | P_2[12] & carry[24];
	assign carry[30] = G_2[14] | P_2[14] & carry[28];
	
	//5th iteration
	assign carry[1] = G_1[0] | P_1[0] & carry[0];
	assign carry[3] = G_1[2] | P_1[2] & carry[2];
	assign carry[5] = G_1[4] | P_1[4] & carry[4];
	assign carry[7] = G_1[6] | P_1[6] & carry[6];
	assign carry[9] = G_1[8] | P_1[8] & carry[8];
	assign carry[11] = G_1[10] | P_1[10] & carry[10];
	assign carry[13] = G_1[12] | P_1[12] & carry[12];
	assign carry[15] = G_1[14] | P_1[14] & carry[14];
	assign carry[17] = G_1[16] | P_1[16] & carry[16];
	assign carry[19] = G_1[18] | P_1[18] & carry[18];
	assign carry[21] = G_1[20] | P_1[20] & carry[20];
	assign carry[23] = G_1[22] | P_1[22] & carry[22];
	assign carry[25] = G_1[24] | P_1[24] & carry[24];
	assign carry[27] = G_1[26] | P_1[26] & carry[26];
	assign carry[29] = G_1[28] | P_1[28] & carry[28];
	assign carry[31] = G_1[30] | P_1[30] & carry[30];
	
	assign sum = P_1 ^ carry[31:0];
	
endmodule
