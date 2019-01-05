/* LGPL Simple, Minimalistic, mp3 decoder based on minimp3
 *	©2017-2018 Yuichiro Nakada
 *
 * Basic usage:
 *
 * */

/*
 * MPEG Audio Layer III decoder
 * Copyright (c) 2001, 2002 Fabrice Bellard,
 *           (c) 2007 Martin J. Fiedler
 *
 * This file is a stripped-down version of the MPEG Audio decoder from
 * the FFmpeg libavcodec library.
 *
 * FFmpeg and minimp3 are free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * FFmpeg and minimp3 are distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with FFmpeg; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */

#define FASTCALL __attribute__((fastcall))

extern mp3_decoder_t mp3_create(void);
extern int mp3_decode(mp3_decoder_t *dec, void *buf, int bytes, signed short *out, mp3_info_t *info);
extern void mp3_done(mp3_decoder_t *dec);
size_t strlen(const char *s);
#define out(text) write(1, (const void *) text, strlen(text))





////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////


#undef UPDATE_CACHE
#undef BF
