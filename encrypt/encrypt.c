#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "calcurse.h"

#define ENCRYPTION_MODE 1
#define DECRYPTION_MODE 0

typedef struct {
	unsigned char k[8];
	unsigned char c[4];
	unsigned char d[4];
} key_set;

static
key_set key_sets[17];

static
const int initial_key_permutaion[] = {57, 49,  41, 33,  25,  17,  9,
								 1, 58,  50, 42,  34,  26, 18,
								10,  2,  59, 51,  43,  35, 27,
								19, 11,   3, 60,  52,  44, 36,
								63, 55,  47, 39,  31,  23, 15,
								 7, 62,  54, 46,  38,  30, 22,
								14,  6,  61, 53,  45,  37, 29,
								21, 13,   5, 28,  20,  12,  4};

static
const int initial_message_permutation[] =	   {58, 50, 42, 34, 26, 18, 10, 2,
										60, 52, 44, 36, 28, 20, 12, 4,
										62, 54, 46, 38, 30, 22, 14, 6,
										64, 56, 48, 40, 32, 24, 16, 8,
										57, 49, 41, 33, 25, 17,  9, 1,
										59, 51, 43, 35, 27, 19, 11, 3,
										61, 53, 45, 37, 29, 21, 13, 5,
										63, 55, 47, 39, 31, 23, 15, 7};

static
const int key_shift_sizes[] = {-1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1};

static
const int sub_key_permutation[] =    {14, 17, 11, 24,  1,  5,
								 3, 28, 15,  6, 21, 10,
								23, 19, 12,  4, 26,  8,
								16,  7, 27, 20, 13,  2,
								41, 52, 31, 37, 47, 55,
								30, 40, 51, 45, 33, 48,
								44, 49, 39, 56, 34, 53,
								46, 42, 50, 36, 29, 32};

static
const int message_expansion[] =  {32,  1,  2,  3,  4,  5,
							 4,  5,  6,  7,  8,  9,
							 8,  9, 10, 11, 12, 13,
							12, 13, 14, 15, 16, 17,
							16, 17, 18, 19, 20, 21,
							20, 21, 22, 23, 24, 25,
							24, 25, 26, 27, 28, 29,
							28, 29, 30, 31, 32,  1};

static
const int S1[] = {14,  4, 13,  1,  2, 15, 11,  8,  3, 10,  6, 12,  5,  9,  0,  7,
			 0, 15,  7,  4, 14,  2, 13,  1, 10,  6, 12, 11,  9,  5,  3,  8,
			 4,  1, 14,  8, 13,  6,  2, 11, 15, 12,  9,  7,  3, 10,  5,  0,
			15, 12,  8,  2,  4,  9,  1,  7,  5, 11,  3, 14, 10,  0,  6, 13};

static
const int S2[] = {15,  1,  8, 14,  6, 11,  3,  4,  9,  7,  2, 13, 12,  0,  5, 10,
			 3, 13,  4,  7, 15,  2,  8, 14, 12,  0,  1, 10,  6,  9, 11,  5,
			 0, 14,  7, 11, 10,  4, 13,  1,  5,  8, 12,  6,  9,  3,  2, 15,
			13,  8, 10,  1,  3, 15,  4,  2, 11,  6,  7, 12,  0,  5, 14,  9};

static
const int S3[] = {10,  0,  9, 14,  6,  3, 15,  5,  1, 13, 12,  7, 11,  4,  2,  8,
			13,  7,  0,  9,  3,  4,  6, 10,  2,  8,  5, 14, 12, 11, 15,  1,
			13,  6,  4,  9,  8, 15,  3,  0, 11,  1,  2, 12,  5, 10, 14,  7,
			 1, 10, 13,  0,  6,  9,  8,  7,  4, 15, 14,  3, 11,  5,  2, 12};

static
const int S4[] = { 7, 13, 14,  3,  0,  6,  9, 10,  1,  2,  8,  5, 11, 12,  4, 15,
			13,  8, 11,  5,  6, 15,  0,  3,  4,  7,  2, 12,  1, 10, 14,  9,
			10,  6,  9,  0, 12, 11,  7, 13, 15,  1,  3, 14,  5,  2,  8,  4,
			 3, 15,  0,  6, 10,  1, 13,  8,  9,  4,  5, 11, 12,  7,  2, 14};
static
const int S5[] = { 2, 12,  4,  1,  7, 10, 11,  6,  8,  5,  3, 15, 13,  0, 14,  9,
			14, 11,  2, 12,  4,  7, 13,  1,  5,  0, 15, 10,  3,  9,  8,  6,
			 4,  2,  1, 11, 10, 13,  7,  8, 15,  9, 12,  5,  6,  3,  0, 14,
			11,  8, 12,  7,  1, 14,  2, 13,  6, 15,  0,  9, 10,  4,  5,  3};

static
const int S6[] = {12,  1, 10, 15,  9,  2,  6,  8,  0, 13,  3,  4, 14,  7,  5, 11,
			10, 15,  4,  2,  7, 12,  9,  5,  6,  1, 13, 14,  0, 11,  3,  8,
			 9, 14, 15,  5,  2,  8, 12,  3,  7,  0,  4, 10,  1, 13, 11,  6,
			 4,  3,  2, 12,  9,  5, 15, 10, 11, 14,  1,  7,  6,  0,  8, 13};
static
const int S7[] = { 4, 11,  2, 14, 15,  0,  8, 13,  3, 12,  9,  7,  5, 10,  6,  1,
			13,  0, 11,  7,  4,  9,  1, 10, 14,  3,  5, 12,  2, 15,  8,  6,
			 1,  4, 11, 13, 12,  3,  7, 14, 10, 15,  6,  8,  0,  5,  9,  2,
			 6, 11, 13,  8,  1,  4, 10,  7,  9,  5,  0, 15, 14,  2,  3, 12};

static
const int S8[] = {13,  2,  8,  4,  6, 15, 11,  1, 10,  9,  3, 14,  5,  0, 12,  7,
			 1, 15, 13,  8, 10,  3,  7,  4, 12,  5,  6, 11,  0, 14,  9,  2,
			 7, 11,  4,  1,  9, 12, 14,  2,  0,  6, 10, 13, 15,  3,  5,  8,
			 2,  1, 14,  7,  4, 10,  8, 13, 15, 12,  9,  0,  3,  5,  6, 11};
static
const int right_sub_message_permutation[] =    {16,  7, 20, 21,
									29, 12, 28, 17,
									 1, 15, 23, 26,
									 5, 18, 31, 10,
									 2,  8, 24, 14,
									32, 27,  3,  9,
									19, 13, 30,  6,
									22, 11,  4, 25};

static
const int final_message_permutation[] =  {40,  8, 48, 16, 56, 24, 64, 32,
									39,  7, 47, 15, 55, 23, 63, 31,
									38,  6, 46, 14, 54, 22, 62, 30,
									37,  5, 45, 13, 53, 21, 61, 29,
									36,  4, 44, 12, 52, 20, 60, 28,
									35,  3, 43, 11, 51, 19, 59, 27,
									34,  2, 42, 10, 50, 18, 58, 26,
									33,  1, 41,  9, 49, 17, 57, 25};
static 
int initflag = 0;	// key 初始化标志

static
void generate_sub_keys(unsigned char* main_key, key_set* key_sets) {
	int i, j;
	int shift_size;
	unsigned char shift_byte, first_shift_bits, second_shift_bits, third_shift_bits, fourth_shift_bits;

	if ( initflag != 0 ) return;
	else initflag = 1;

	for (i=0; i<8; i++) {
		key_sets[0].k[i] = 0;
	}

	for (i=0; i<56; i++) {
		shift_size = initial_key_permutaion[i];
		shift_byte = 0x80 >> ((shift_size - 1)%8);
		shift_byte &= main_key[(shift_size - 1)/8];
		shift_byte <<= ((shift_size - 1)%8);

		key_sets[0].k[i/8] |= (shift_byte >> i%8);
	}

	for (i=0; i<3; i++) {
		key_sets[0].c[i] = key_sets[0].k[i];
	}

	key_sets[0].c[3] = key_sets[0].k[3] & 0xF0;

	for (i=0; i<3; i++) {
		key_sets[0].d[i] = (key_sets[0].k[i+3] & 0x0F) << 4;
		key_sets[0].d[i] |= (key_sets[0].k[i+4] & 0xF0) >> 4;
	}

	key_sets[0].d[3] = (key_sets[0].k[6] & 0x0F) << 4;

	for (i=1; i<17; i++) {
		for (j=0; j<4; j++) {
			key_sets[i].c[j] = key_sets[i-1].c[j];
			key_sets[i].d[j] = key_sets[i-1].d[j];
		}

		shift_size = key_shift_sizes[i];
		if (shift_size == 1){
			shift_byte = 0x80;
		} else {
			shift_byte = 0xC0;
		}

		// Process C
		first_shift_bits = shift_byte & key_sets[i].c[0];
		second_shift_bits = shift_byte & key_sets[i].c[1];
		third_shift_bits = shift_byte & key_sets[i].c[2];
		fourth_shift_bits = shift_byte & key_sets[i].c[3];

		key_sets[i].c[0] <<= shift_size;
		key_sets[i].c[0] |= (second_shift_bits >> (8 - shift_size));

		key_sets[i].c[1] <<= shift_size;
		key_sets[i].c[1] |= (third_shift_bits >> (8 - shift_size));

		key_sets[i].c[2] <<= shift_size;
		key_sets[i].c[2] |= (fourth_shift_bits >> (8 - shift_size));

		key_sets[i].c[3] <<= shift_size;
		key_sets[i].c[3] |= (first_shift_bits >> (4 - shift_size));

		// Process D
		first_shift_bits = shift_byte & key_sets[i].d[0];
		second_shift_bits = shift_byte & key_sets[i].d[1];
		third_shift_bits = shift_byte & key_sets[i].d[2];
		fourth_shift_bits = shift_byte & key_sets[i].d[3];

		key_sets[i].d[0] <<= shift_size;
		key_sets[i].d[0] |= (second_shift_bits >> (8 - shift_size));

		key_sets[i].d[1] <<= shift_size;
		key_sets[i].d[1] |= (third_shift_bits >> (8 - shift_size));

		key_sets[i].d[2] <<= shift_size;
		key_sets[i].d[2] |= (fourth_shift_bits >> (8 - shift_size));

		key_sets[i].d[3] <<= shift_size;
		key_sets[i].d[3] |= (first_shift_bits >> (4 - shift_size));

		for (j=0; j<48; j++) {
			shift_size = sub_key_permutation[j];
			if (shift_size <= 28) {
				shift_byte = 0x80 >> ((shift_size - 1)%8);
				shift_byte &= key_sets[i].c[(shift_size - 1)/8];
				shift_byte <<= ((shift_size - 1)%8);
			} else {
				shift_byte = 0x80 >> ((shift_size - 29)%8);
				shift_byte &= key_sets[i].d[(shift_size - 29)/8];
				shift_byte <<= ((shift_size - 29)%8);
			}

			key_sets[i].k[j/8] |= (shift_byte >> j%8);
		}
	}
}

static
void process_message(unsigned char* message_piece, unsigned char* processed_piece, key_set* key_sets, int mode) {
	int i, k;
	int shift_size;
	unsigned char shift_byte;

	unsigned char initial_permutation[8];
	memset(initial_permutation, 0, 8);
	memset(processed_piece, 0, 8);

	for (i=0; i<64; i++) {
		shift_size = initial_message_permutation[i];
		shift_byte = 0x80 >> ((shift_size - 1)%8);
		shift_byte &= message_piece[(shift_size - 1)/8];
		shift_byte <<= ((shift_size - 1)%8);

		initial_permutation[i/8] |= (shift_byte >> i%8);
	}

	unsigned char l[4], r[4];
	for (i=0; i<4; i++) {
		l[i] = initial_permutation[i];
		r[i] = initial_permutation[i+4];
	}

	unsigned char ln[4], rn[4], er[6], ser[4];

	int key_index;
	for (k=1; k<=16; k++) {
		memcpy(ln, r, 4);

		memset(er, 0, 6);

		for (i=0; i<48; i++) {
			shift_size = message_expansion[i];
			shift_byte = 0x80 >> ((shift_size - 1)%8);
			shift_byte &= r[(shift_size - 1)/8];
			shift_byte <<= ((shift_size - 1)%8);

			er[i/8] |= (shift_byte >> i%8);
		}

		if (mode == DECRYPTION_MODE) {
			key_index = 17 - k;
		} else {
			key_index = k;
		}

		for (i=0; i<6; i++) {
			er[i] ^= key_sets[key_index].k[i];
		}

		unsigned char row, column;

		for (i=0; i<4; i++) {
			ser[i] = 0;
		}

		// 0000 0000 0000 0000 0000 0000
		// rccc crrc cccr rccc crrc cccr

		// Byte 1
		row = 0;
		row |= ((er[0] & 0x80) >> 6);
		row |= ((er[0] & 0x04) >> 2);

		column = 0;
		column |= ((er[0] & 0x78) >> 3);

		ser[0] |= ((unsigned char)S1[row*16+column] << 4);

		row = 0;
		row |= (er[0] & 0x02);
		row |= ((er[1] & 0x10) >> 4);

		column = 0;
		column |= ((er[0] & 0x01) << 3);
		column |= ((er[1] & 0xE0) >> 5);

		ser[0] |= (unsigned char)S2[row*16+column];

		// Byte 2
		row = 0;
		row |= ((er[1] & 0x08) >> 2);
		row |= ((er[2] & 0x40) >> 6);

		column = 0;
		column |= ((er[1] & 0x07) << 1);
		column |= ((er[2] & 0x80) >> 7);

		ser[1] |= ((unsigned char)S3[row*16+column] << 4);

		row = 0;
		row |= ((er[2] & 0x20) >> 4);
		row |= (er[2] & 0x01);

		column = 0;
		column |= ((er[2] & 0x1E) >> 1);

		ser[1] |= (unsigned char)S4[row*16+column];

		// Byte 3
		row = 0;
		row |= ((er[3] & 0x80) >> 6);
		row |= ((er[3] & 0x04) >> 2);

		column = 0;
		column |= ((er[3] & 0x78) >> 3);

		ser[2] |= ((unsigned char)S5[row*16+column] << 4);

		row = 0;
		row |= (er[3] & 0x02);
		row |= ((er[4] & 0x10) >> 4);

		column = 0;
		column |= ((er[3] & 0x01) << 3);
		column |= ((er[4] & 0xE0) >> 5);

		ser[2] |= (unsigned char)S6[row*16+column];

		// Byte 4
		row = 0;
		row |= ((er[4] & 0x08) >> 2);
		row |= ((er[5] & 0x40) >> 6);

		column = 0;
		column |= ((er[4] & 0x07) << 1);
		column |= ((er[5] & 0x80) >> 7);

		ser[3] |= ((unsigned char)S7[row*16+column] << 4);

		row = 0;
		row |= ((er[5] & 0x20) >> 4);
		row |= (er[5] & 0x01);

		column = 0;
		column |= ((er[5] & 0x1E) >> 1);

		ser[3] |= (unsigned char)S8[row*16+column];

		for (i=0; i<4; i++) {
			rn[i] = 0;
		}

		for (i=0; i<32; i++) {
			shift_size = right_sub_message_permutation[i];
			shift_byte = 0x80 >> ((shift_size - 1)%8);
			shift_byte &= ser[(shift_size - 1)/8];
			shift_byte <<= ((shift_size - 1)%8);

			rn[i/8] |= (shift_byte >> i%8);
		}

		for (i=0; i<4; i++) {
			rn[i] ^= l[i];
		}

		for (i=0; i<4; i++) {
			l[i] = ln[i];
			r[i] = rn[i];
		}
	}

	unsigned char pre_end_permutation[8];
	for (i=0; i<4; i++) {
		pre_end_permutation[i] = r[i];
		pre_end_permutation[4+i] = l[i];
	}

	for (i=0; i<64; i++) {
		shift_size = final_message_permutation[i];
		shift_byte = 0x80 >> ((shift_size - 1)%8);
		shift_byte &= pre_end_permutation[(shift_size - 1)/8];
		shift_byte <<= ((shift_size - 1)%8);

		processed_piece[i/8] |= (shift_byte >> i%8);
	}
}

#define ENCRYPT_FILE_HEAD "encryptfile_v1.0.0"
static FILE *input_file, *output_file;
static unsigned char des_key[8] = {0x44,0x0F,0xE8,0xEC,0x0A,0x6C,0xF3,0x69};

/* 
 * 确认是否文件是否是已经加密过的文件
 *
 * file: 需要确认的文件的路径
 * return: 0: 是encrypt文件 
 *	  -1: 非encrypt文件 
 */
static 
int is_encrypt_file(const char* filepath)
{
	int encrypt_head_length = strlen(ENCRYPT_FILE_HEAD);
	FILE* inputfile = fopen(filepath, "rb");
	if (!inputfile) {
		DMON_LOG("Could not open input file to read data.");
		return -1;
	}
	rewind(inputfile);
	unsigned long file_size;
	fseek(inputfile, 0L, SEEK_END);
	file_size = ftell(inputfile);
	fseek(inputfile, 0L, SEEK_SET);

	if ( file_size < encrypt_head_length )
		goto Exit;

	char* head = (char*) malloc(encrypt_head_length*sizeof(char)+1);
	fread(head,encrypt_head_length,1,inputfile);
	if ( strncmp(head,ENCRYPT_FILE_HEAD,encrypt_head_length) == 0 )
	{
		free(head);
		head = NULL;
		fclose(inputfile);
		return 0;
	}

	free(head);
	head = NULL;
Exit:
	fclose(inputfile);
	return -1;
}

static
int add_head_process(const char* src,const char* des)
{
	FILE *src_h,*des_h;
	int encrypt_head_length = strlen(ENCRYPT_FILE_HEAD);
	src_h = fopen(src,"rb");
	if ( !src_h  ) {
		DMON_LOG("Could not open input file to read data.");
		return -1;
	}
	rewind(src_h);

	des_h = fopen(des,"wb");
	if ( !des_h ) {
		fclose(src_h);
		DMON_LOG("Could not open output file to write data.");
		return -1;
	}
	rewind(des_h);

	fwrite(ENCRYPT_FILE_HEAD,encrypt_head_length,1,des_h);
	int ch;
	while((ch=getc(src_h)) != EOF) {
		fputc(ch,des_h);
	}

	int fd = fileno(des_h);
	fflush(des_h);
	fsync(fd);

	fclose(src_h);
	fclose(des_h);
	return 0;
}

static
int sub_head_process(const char* src,const char* des)
{
	FILE *src_h,*des_h;
	int encrypt_head_length = strlen(ENCRYPT_FILE_HEAD);
	src_h = fopen(src,"rb");
	if ( !src_h  ) {
		DMON_LOG("Could not open input file to read data.");
		return -1;
	}
	rewind(src_h);

	des_h = fopen(des,"wb");
	if ( !des_h ) {
		fclose(src_h);
		DMON_LOG("Could not open output file to write data.");
		return -1;
	}
	rewind(des_h);

	fseek(src_h,encrypt_head_length,SEEK_SET);

	int ch;
	while((ch=getc(src_h)) != EOF) {
		fputc(ch,des_h);
	}

	int fd = fileno(des_h);
	fflush(des_h);
	fsync(fd);

	fclose(src_h);
	fclose(des_h);
	return 0;
}

/* 
 * 添加加密文件的头，或是祛除加密文件的头
 *
 * filepath: 需要加密的文件路径
 * f       : 'a' 添加文件头
 *         : 's' 祛除文件头
 * 
 */
static
int head_process(const char* filepath,char f)
{
	char tmpfile[128];
	sprintf(tmpfile,"%s.xxxmtmp",filepath);
	if ( f == 'a' )
	{
		if (add_head_process(filepath,tmpfile) == 0)
		{
			rename_file(tmpfile,filepath);
			return 0;
		}

	}
	else if ( f == 's' )
	{
		if (sub_head_process(filepath,tmpfile) == 0)
		{
			rename_file(tmpfile,filepath);
			return 0;
		}

	}

	return -1;
}

/*
 * 处理加密/解密函数 
 * srcf: 输入文件的函数路径
 * desf: 输出文件的函数路径
 *    m: 'e':加密 'd':解密
 *
 * return: 0: 成功
 *         -1: 失败
 */
static
int encrypt_process(const char* src,const char* des,char m)
{
	unsigned long file_size;
	unsigned short int padding;

	// Open input file
	input_file = fopen(src, "rb");
	if (!input_file) {
		DMON_LOG("Could not open input file to read data.");
		return -1;
	}
	rewind(input_file);			// 非常重要

	// Open output file
	output_file = fopen(des, "wb");
	if (!output_file) {
		fclose(input_file);
		DMON_LOG("Could not open output file to write data.");
		return -1;
	}
	rewind(output_file);			// 非常重要

	// Generate DES key set
	short int process_mode = ENCRYPTION_MODE;
	unsigned long block_count = 0, number_of_blocks;
	unsigned char* data_block = (unsigned char*) malloc(8*sizeof(char));
	unsigned char* processed_block = (unsigned char*) malloc(8*sizeof(char));

	generate_sub_keys(des_key, key_sets);

	// Determine process mode
	if ( m == 'e' )	
		process_mode = ENCRYPTION_MODE;
	else if ( m == 'd' )
		process_mode = DECRYPTION_MODE;

	// Get number of blocks in the file
	fseek(input_file, 0L, SEEK_END);
	file_size = ftell(input_file);

	fseek(input_file, 0L, SEEK_SET);
	number_of_blocks = file_size/8 + ((file_size%8)?1:0);

	// Start reading input file, process and write to output file
	while(fread(data_block, 1, 8, input_file)) {
		block_count++;
		if (block_count == number_of_blocks) {
			if (process_mode == ENCRYPTION_MODE) {
				padding = 8 - file_size%8;
				if (padding < 8) { // Fill empty data block bytes with padding
					memset((data_block + 8 - padding), (unsigned char)padding, padding);
				}

				process_message(data_block, processed_block, key_sets, process_mode);
				fwrite(processed_block, 1, 8, output_file);

				if (padding == 8) { // Write an extra block for padding
					memset(data_block, (unsigned char)padding, 8);
					process_message(data_block, processed_block, key_sets, process_mode);
					fwrite(processed_block, 1, 8, output_file);
				}
			} else {
				process_message(data_block, processed_block, key_sets, process_mode);
				padding = processed_block[7];

				if (padding < 8) {
					fwrite(processed_block, 1, 8 - padding, output_file);
				}
			}
		} else {
			process_message(data_block, processed_block, key_sets, process_mode);
			fwrite(processed_block, 1, 8, output_file);
		}
		memset(data_block, 0, 8);
	}

	// Free up memory
	free(data_block);
	free(processed_block);
	fclose(input_file);

	int fd = fileno(output_file);
	fflush(output_file);
	fsync(fd);

	fclose(output_file);

	return 0;
}

int unlink_file(const char* file) 
{
	if ( !access(file,F_OK) )
	{
		if ( !unlink(file) )
			return 0;
	}
	return -1;
}

int rename_file(const char* src,const char* des)
{
	if ( !access(src,F_OK) )
	{
		if ( !rename(src,des) )
			return 0;
	}
	return -1;
}

int copy_file(const char* src,const char* des)
{
	FILE *src_h,*des_h;
	src_h = fopen(src,"rb");
	if ( !src_h  ) {
		return -1;
	}
	rewind(src_h);

	des_h = fopen(des,"wb");
	if ( !des_h ) {
		fclose(src_h);
		return -1;
	}
	rewind(des_h);

	int ch;
	while((ch=getc(src_h)) != EOF) {
		fputc(ch,des_h);
	}

	rewind(des_h);
	int fd = fileno(des_h);
	fflush(des_h);
	fsync(fd);

	fclose(src_h);
	fclose(des_h);
	return 0;
}

void encrypt_file(const char* src,const char* des)
{
	if ( is_encrypt_file(src) == -1 )
	{
		encrypt_process(src,des,'e');
		head_process(des,'a');
	}
}

void decrypt_file(const char* src,const char* des)
{
	if ( is_encrypt_file(src) == 0 )
	{
		head_process(src,'s');
		encrypt_process(src,des,'d');
	}
	else 
		copy_file(src,des);
}
