% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=1
% probarg formalism=PAF
% probarg generator=PW24-full-grid-v1
% probarg generator_sha256=d9200c83ef88f7fa6010122c137a46d4edbd46639b62fb91cc5cff0fa9398b5e
% probarg k=2
% probarg master_seed=20261106
% probarg n=10
% probarg probability_scale=10000
% probarg replicate=36
% probarg runner_sha256=23de6e43f4f7384bf7a3ffba9608f63b0652715f7a5bc36353d90db5a4da8e70
% probarg seed=7212056167036863748
% probarg source_commit=df7961a39dc666610298d7d2539ee2a8da315508
% probarg source_sha256=54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38
arg(a0).
arg(a1).
arg(a10).
arg(a11).
arg(a12).
arg(a13).
arg(a14).
arg(a15).
arg(a16).
arg(a17).
arg(a18).
arg(a19).
arg(a2).
arg(a3).
arg(a4).
arg(a5).
arg(a6).
arg(a7).
arg(a8).
arg(a9).
p(a17,1000).
p(a5,7000).
p(a19,4000).
p(a7,5000).
p(a13,4000).
p(a15,2000).
p(a14,6000).
p(a6,2000).
p(a4,3000).
p(a3,8000).
p(a0,8000).
p(a8,6000).
p(a11,4000).
p(a10,4000).
p(a12,2000).
p(a9,7000).
p(a2,1000).
p(a18,2000).
p(a1,4000).
p(a16,5000).
att(a19,a17).
att(a5,a17).
att(a7,a5).
att(a19,a13).
att(a13,a19).
att(a19,a7).
att(a7,a15).
att(a14,a13).
att(a13,a15).
att(a15,a6).
att(a6,a15).
att(a4,a14).
att(a6,a14).
att(a3,a6).
att(a4,a0).
att(a0,a4).
att(a4,a3).
att(a3,a4).
att(a3,a8).
att(a0,a11).
att(a0,a8).
att(a8,a10).
att(a12,a11).
att(a11,a10).
att(a10,a9).
att(a12,a2).
att(a12,a9).
att(a9,a12).
att(a9,a18).
att(a2,a1).
att(a1,a2).
att(a18,a2).
att(a16,a18).
att(a16,a1).
p(0,a19,a17,7000).
p(1,a5,a17,9000).
p(2,a7,a5,9000).
p(3,a19,a13,6000).
p(4,a13,a19,2000).
p(5,a19,a7,8000).
p(6,a7,a15,7000).
p(7,a14,a13,5000).
p(8,a13,a15,6000).
p(9,a15,a6,8000).
p(10,a6,a15,1000).
p(11,a4,a14,7000).
p(12,a6,a14,1000).
p(13,a3,a6,5000).
p(14,a4,a0,3000).
p(15,a0,a4,3000).
p(16,a4,a3,9000).
p(17,a3,a4,2000).
p(18,a3,a8,2000).
p(19,a0,a11,7000).
p(20,a0,a8,6000).
p(21,a8,a10,1000).
p(22,a12,a11,7000).
p(23,a11,a10,7000).
p(24,a10,a9,7000).
p(25,a12,a2,7000).
p(26,a12,a9,8000).
p(27,a9,a12,7000).
p(28,a9,a18,1000).
p(29,a2,a1,1000).
p(30,a1,a2,4000).
p(31,a18,a2,6000).
p(32,a16,a18,2000).
p(33,a16,a1,5000).
query(a12).