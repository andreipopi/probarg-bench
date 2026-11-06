% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=1
% probarg formalism=PAF
% probarg generator=PW24-full-grid-v1
% probarg generator_sha256=d9200c83ef88f7fa6010122c137a46d4edbd46639b62fb91cc5cff0fa9398b5e
% probarg k=6
% probarg master_seed=20261106
% probarg n=3
% probarg probability_scale=10000
% probarg replicate=273
% probarg runner_sha256=23de6e43f4f7384bf7a3ffba9608f63b0652715f7a5bc36353d90db5a4da8e70
% probarg seed=15211247778995865908
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
arg(a2).
arg(a3).
arg(a4).
arg(a5).
arg(a6).
arg(a7).
arg(a8).
arg(a9).
p(a3,2000).
p(a9,7000).
p(a8,9000).
p(a16,7000).
p(a15,6000).
p(a14,8000).
p(a0,6000).
p(a6,7000).
p(a12,2000).
p(a1,3000).
p(a2,2000).
p(a10,4000).
p(a13,3000).
p(a5,5000).
p(a17,8000).
p(a11,5000).
p(a7,1000).
p(a4,5000).
att(a3,a0).
att(a0,a3).
att(a3,a9).
att(a9,a3).
att(a6,a9).
att(a9,a8).
att(a12,a8).
att(a8,a16).
att(a16,a1).
att(a1,a16).
att(a16,a15).
att(a15,a16).
att(a15,a2).
att(a14,a15).
att(a14,a10).
att(a0,a13).
att(a13,a0).
att(a0,a6).
att(a5,a6).
att(a12,a6).
att(a17,a12).
att(a12,a1).
att(a11,a1).
att(a1,a2).
att(a2,a7).
att(a7,a2).
att(a10,a2).
att(a10,a4).
att(a4,a10).
att(a5,a13).
att(a5,a17).
att(a11,a17).
att(a7,a11).
att(a4,a7).
p(0,a3,a0,5000).
p(1,a0,a3,6000).
p(2,a3,a9,5000).
p(3,a9,a3,9000).
p(4,a6,a9,9000).
p(5,a9,a8,8000).
p(6,a12,a8,1000).
p(7,a8,a16,2000).
p(8,a16,a1,1000).
p(9,a1,a16,4000).
p(10,a16,a15,2000).
p(11,a15,a16,2000).
p(12,a15,a2,4000).
p(13,a14,a15,3000).
p(14,a14,a10,9000).
p(15,a0,a13,4000).
p(16,a13,a0,3000).
p(17,a0,a6,1000).
p(18,a5,a6,6000).
p(19,a12,a6,2000).
p(20,a17,a12,8000).
p(21,a12,a1,4000).
p(22,a11,a1,5000).
p(23,a1,a2,2000).
p(24,a2,a7,6000).
p(25,a7,a2,5000).
p(26,a10,a2,9000).
p(27,a10,a4,6000).
p(28,a4,a10,7000).
p(29,a5,a13,7000).
p(30,a5,a17,1000).
p(31,a11,a17,9000).
p(32,a7,a11,7000).
p(33,a4,a7,3000).
query(a4).