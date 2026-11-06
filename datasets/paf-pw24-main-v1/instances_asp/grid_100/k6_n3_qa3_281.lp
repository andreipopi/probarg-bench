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
% probarg replicate=281
% probarg runner_sha256=23de6e43f4f7384bf7a3ffba9608f63b0652715f7a5bc36353d90db5a4da8e70
% probarg seed=16876077991953589895
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
p(a9,2000).
p(a6,7000).
p(a12,2000).
p(a7,2000).
p(a8,1000).
p(a15,4000).
p(a16,4000).
p(a14,6000).
p(a4,3000).
p(a13,3000).
p(a0,1000).
p(a10,3000).
p(a2,5000).
p(a17,3000).
p(a5,6000).
p(a11,7000).
p(a1,9000).
p(a3,4000).
att(a9,a16).
att(a16,a9).
att(a9,a6).
att(a6,a9).
att(a6,a14).
att(a6,a12).
att(a12,a6).
att(a12,a4).
att(a4,a12).
att(a12,a7).
att(a7,a12).
att(a7,a13).
att(a7,a8).
att(a8,a7).
att(a8,a0).
att(a0,a8).
att(a8,a15).
att(a15,a8).
att(a10,a15).
att(a16,a2).
att(a14,a16).
att(a17,a14).
att(a4,a14).
att(a4,a5).
att(a4,a13).
att(a13,a4).
att(a11,a13).
att(a13,a0).
att(a0,a1).
att(a1,a0).
att(a0,a10).
att(a10,a0).
att(a3,a10).
att(a17,a2).
att(a5,a17).
att(a5,a11).
att(a11,a5).
att(a11,a1).
att(a1,a11).
att(a3,a1).
p(0,a9,a16,2000).
p(1,a16,a9,9000).
p(2,a9,a6,6000).
p(3,a6,a9,7000).
p(4,a6,a14,7000).
p(5,a6,a12,1000).
p(6,a12,a6,9000).
p(7,a12,a4,7000).
p(8,a4,a12,7000).
p(9,a12,a7,9000).
p(10,a7,a12,6000).
p(11,a7,a13,2000).
p(12,a7,a8,8000).
p(13,a8,a7,3000).
p(14,a8,a0,6000).
p(15,a0,a8,7000).
p(16,a8,a15,9000).
p(17,a15,a8,6000).
p(18,a10,a15,6000).
p(19,a16,a2,3000).
p(20,a14,a16,4000).
p(21,a17,a14,5000).
p(22,a4,a14,2000).
p(23,a4,a5,9000).
p(24,a4,a13,4000).
p(25,a13,a4,9000).
p(26,a11,a13,8000).
p(27,a13,a0,2000).
p(28,a0,a1,4000).
p(29,a1,a0,8000).
p(30,a0,a10,9000).
p(31,a10,a0,1000).
p(32,a3,a10,2000).
p(33,a17,a2,8000).
p(34,a5,a17,7000).
p(35,a5,a11,1000).
p(36,a11,a5,5000).
p(37,a11,a1,4000).
p(38,a1,a11,8000).
p(39,a3,a1,1000).
query(a3).