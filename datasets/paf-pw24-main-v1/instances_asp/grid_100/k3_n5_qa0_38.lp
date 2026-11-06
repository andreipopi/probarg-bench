% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=1
% probarg formalism=PAF
% probarg generator=PW24-full-grid-v1
% probarg generator_sha256=d9200c83ef88f7fa6010122c137a46d4edbd46639b62fb91cc5cff0fa9398b5e
% probarg k=3
% probarg master_seed=20261106
% probarg n=5
% probarg probability_scale=10000
% probarg replicate=38
% probarg runner_sha256=23de6e43f4f7384bf7a3ffba9608f63b0652715f7a5bc36353d90db5a4da8e70
% probarg seed=9019584122157621309
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
p(a6,4000).
p(a5,7000).
p(a12,7000).
p(a13,4000).
p(a1,6000).
p(a4,9000).
p(a9,9000).
p(a11,8000).
p(a14,2000).
p(a7,6000).
p(a2,7000).
p(a8,9000).
p(a0,4000).
p(a3,4000).
att(a12,a10).
att(a10,a6).
att(a6,a13).
att(a13,a6).
att(a6,a5).
att(a5,a6).
att(a5,a1).
att(a1,a5).
att(a4,a12).
att(a13,a12).
att(a13,a9).
att(a9,a13).
att(a13,a1).
att(a11,a1).
att(a4,a14).
att(a4,a9).
att(a7,a9).
att(a9,a11).
att(a11,a9).
att(a11,a2).
att(a2,a11).
att(a14,a8).
att(a8,a14).
att(a14,a7).
att(a7,a0).
att(a0,a7).
att(a7,a2).
att(a3,a2).
att(a8,a0).
att(a0,a8).
att(a0,a3).
att(a3,a0).
p(0,a12,a10,6000).
p(1,a10,a6,4000).
p(2,a6,a13,5000).
p(3,a13,a6,9000).
p(4,a6,a5,6000).
p(5,a5,a6,7000).
p(6,a5,a1,8000).
p(7,a1,a5,9000).
p(8,a4,a12,8000).
p(9,a13,a12,6000).
p(10,a13,a9,5000).
p(11,a9,a13,3000).
p(12,a13,a1,6000).
p(13,a11,a1,5000).
p(14,a4,a14,9000).
p(15,a4,a9,1000).
p(16,a7,a9,7000).
p(17,a9,a11,5000).
p(18,a11,a9,9000).
p(19,a11,a2,7000).
p(20,a2,a11,7000).
p(21,a14,a8,9000).
p(22,a8,a14,1000).
p(23,a14,a7,2000).
p(24,a7,a0,9000).
p(25,a0,a7,6000).
p(26,a7,a2,3000).
p(27,a3,a2,2000).
p(28,a8,a0,2000).
p(29,a0,a8,7000).
p(30,a0,a3,5000).
p(31,a3,a0,1000).
query(a0).