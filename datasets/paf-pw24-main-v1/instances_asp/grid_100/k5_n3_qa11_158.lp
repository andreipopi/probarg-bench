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
% probarg replicate=158
% probarg runner_sha256=23de6e43f4f7384bf7a3ffba9608f63b0652715f7a5bc36353d90db5a4da8e70
% probarg seed=5800518539236964286
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
p(a10,4000).
p(a9,4000).
p(a2,1000).
p(a8,2000).
p(a5,7000).
p(a0,7000).
p(a14,8000).
p(a11,5000).
p(a12,5000).
p(a13,4000).
p(a3,8000).
p(a4,6000).
p(a1,6000).
p(a7,1000).
p(a6,6000).
att(a10,a0).
att(a0,a10).
att(a10,a9).
att(a9,a14).
att(a14,a9).
att(a2,a9).
att(a2,a11).
att(a11,a2).
att(a2,a8).
att(a8,a2).
att(a12,a8).
att(a8,a5).
att(a13,a5).
att(a3,a0).
att(a14,a0).
att(a14,a4).
att(a11,a14).
att(a11,a1).
att(a12,a11).
att(a12,a7).
att(a12,a13).
att(a6,a13).
att(a3,a4).
att(a1,a4).
att(a1,a7).
att(a7,a1).
att(a7,a6).
p(0,a10,a0,3000).
p(1,a0,a10,7000).
p(2,a10,a9,6000).
p(3,a9,a14,7000).
p(4,a14,a9,8000).
p(5,a2,a9,5000).
p(6,a2,a11,6000).
p(7,a11,a2,4000).
p(8,a2,a8,4000).
p(9,a8,a2,4000).
p(10,a12,a8,3000).
p(11,a8,a5,3000).
p(12,a13,a5,6000).
p(13,a3,a0,7000).
p(14,a14,a0,9000).
p(15,a14,a4,1000).
p(16,a11,a14,2000).
p(17,a11,a1,7000).
p(18,a12,a11,7000).
p(19,a12,a7,1000).
p(20,a12,a13,9000).
p(21,a6,a13,9000).
p(22,a3,a4,5000).
p(23,a1,a4,6000).
p(24,a1,a7,1000).
p(25,a7,a1,4000).
p(26,a7,a6,1000).
query(a11).