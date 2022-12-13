%ifdef CONFIG
{
  "HostFeatures": ["AVX"],
  "RegData": {
    "XMM0": ["0x414243443E800000", "0x5152535455565758", "0x0000000000000000", "0x0000000000000000"],
    "XMM1": ["0x4142434440800000", "0x5152535455565758", "0x5152535455565758", "0x5152535455565758"],
    "XMM2": ["0x414243443F100000", "0x5152535455565758", "0x0000000000000000", "0x0000000000000000"],
    "XMM3": ["0x4142434441800000", "0x5152535455565758", "0x5152535455565758", "0x5152535455565758"],
    "XMM4": ["0x4142434441C80000", "0x5152535455565758", "0x0000000000000000", "0x0000000000000000"],
    "XMM5": ["0x4142434440C80000", "0x5152535455565758", "0x0000000000000000", "0x0000000000000000"],
    "XMM7": ["0x414243443F23D70A", "0x5152535455565758", "0x0000000000000000", "0x0000000000000000"],
    "XMM8": ["0x4142434441800000", "0x5152535455565758", "0x5152535455565758", "0x5152535455565758"],
    "XMM9": ["0x4142434441C80000", "0x5152535455565758", "0x5152535455565758", "0x5152535455565758"]
  },
  "MemoryRegions": {
    "0x100000000": "4096"
  }
}
%endif

lea rdx, [rel .data]

vmovapd ymm0, [rdx + 32 * 0]
vmovapd ymm1, [rdx + 32 * 1]
vmovapd ymm2, [rdx + 32 * 2]
vmovapd ymm3, [rdx + 32 * 3]
vmovapd ymm4, [rdx + 32 * 4]

; Register only
vdivss xmm0, xmm0, xmm1
vdivss xmm2, xmm2, xmm3

; Memory operand
vdivss xmm5, xmm4, [rdx + 32 * 1]
vdivss xmm4, xmm4, [rdx + 32 * 0]

; Merging different src into destination
vpxor xmm7, xmm7, xmm7
vmovapd ymm8, [rdx + 32 * 3]
vmovapd ymm9, [rdx + 32 * 4]
vdivss xmm7, xmm8, xmm9

hlt

align 32
.data:
dq 0x414243443F800000 ; 1.0
dq 0x5152535455565758
dq 0x5152535455565758
dq 0x5152535455565758

dq 0x4142434440800000 ; 4.0
dq 0x5152535455565758
dq 0x5152535455565758
dq 0x5152535455565758

dq 0x4142434441100000 ; 9.0
dq 0x5152535455565758
dq 0x5152535455565758
dq 0x5152535455565758

dq 0x4142434441800000 ; 16.0
dq 0x5152535455565758
dq 0x5152535455565758
dq 0x5152535455565758

dq 0x4142434441C80000 ; 25.0
dq 0x5152535455565758
dq 0x5152535455565758
dq 0x5152535455565758