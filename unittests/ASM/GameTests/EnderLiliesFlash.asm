%ifdef CONFIG
{
  "RegData": {
    "XMM0": ["0x408000003f800000", "0"],
    "XMM1": ["0x400000003f800000", "0x4080000040400000"]
  }
}
%endif

; This bug was encountered in Ender Lilies, when an enemy attacked the player character there was a chance for a black screen flash.
; This was due to a bug in FEX's `ZextAndMaskingElimination` pass which tries to remove useless vmov IR operations.
; It incorrectly removed vmov IR operations that were explicitly zero extending vectors.
; This vmov IR operation was generated by the movq instruction because the upper bits must be zero.
; When vmov was removed, it would no longer zero the upper 64-bits, which left data in the register.
; This results in a bad calculation.
movaps  xmm1, [rel .data_1]
movq    xmm0, xmm1
mulps   xmm0, [rel .data_1]

hlt

align 16
.data_1:
dd 1.0, 2.0, 3.0, 4.0