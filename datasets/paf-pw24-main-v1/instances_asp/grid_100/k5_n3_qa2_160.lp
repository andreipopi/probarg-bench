% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=1
% probarg formalism=PAF
% probarg generator=PW24-full-grid-v1
% probarg generator_sha256=d9200c83ef88f7fa6010122c137a46d4edbd46639b62fb91cc5cff0fa9398b5e
% probarg k=5
% probarg master_seed=20261106
% probarg n=3
% probarg probability_scale=10000
% probarg replicate=160
% probarg runner_sha256=23de6e43f4f7384bf7a3ffba9608f63b0652715f7a5bc36353d90db5a4da8e70
% probarg seed=4426348033613286978
% probarg source_commit=df7961a39dc666610298d7d2539ee2a8da315508
% probarg source_sha256=54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38
arg(a0).
arg(a1).
arg(a10).
arg(a11).
arg(a12).
arg(a13).
arg(a14).
arg(a2).
arg(a3).
arg(a4).
arg(a5).
arg(a6).
arg(a7).
arg(a8).
arg(a9).
p(a6,4000).
p(a14,3000).
p(a9,3000).
p(a7,1000).
p(a5,6000).
p(a0,2000).
p(a13,1000).
p(a4,8000).
p(a11,1000).
p(a8,6000).
p(a3,2000).
p(a10,2000).
p(a12,7000).
p(a1,1000).
p(a2,9000).
att(a6,a0).
att(a0,a6).
att(a6,a14).
att(a14,a13).
att(a14,a9).
att(a9,a4).
att(a4,a9).
att(a9,a7).
att(a7,a11).
att(a11,a7).
att(a7,a5).
att(a5,a8).
att(a3,a0).
att(a0,a13).
att(a13,a10).
att(a13,a4).
att(a4,a13).
att(a12,a4).
att(a4,a11).
att(a11,a4).
att(a11,a1).
att(a11,a8).
att(a8,a2).
att(a3,a10).
att(a10,a3).
att(a10,a12).
att(a12,a1).
att(a1,a12).
att(a2,a1).
p(0,a6,a0,3000).
p(1,a0,a6,1000).
p(2,a6,a14,8000).
p(3,a14,a13,2000).
p(4,a14,a9,9000).
p(5,a9,a4,6000).
p(6,a4,a9,4000).
p(7,a9,a7,9000).
p(8,a7,a11,3000).
p(9,a11,a7,1000).
p(10,a7,a5,3000).
p(11,a5,a8,8000).
p(12,a3,a0,4000).
p(13,a0,a13,2000).
p(14,a13,a10,4000).
p(15,a13,a4,5000).
p(16,a4,a13,3000).
p(17,a12,a4,9000).
p(18,a4,a11,5000).
p(19,a11,a4,8000).
p(20,a11,a1,2000).
p(21,a11,a8,4000).
p(22,a8,a2,5000).
p(23,a3,a10,8000).
p(24,a10,a3,8000).
p(25,a10,a12,2000).
p(26,a12,a1,1000).
p(27,a1,a12,5000).
p(28,a2,a1,6000).
query(a2).