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
% probarg replicate=277
% probarg runner_sha256=23de6e43f4f7384bf7a3ffba9608f63b0652715f7a5bc36353d90db5a4da8e70
% probarg seed=1209617680585742868
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
p(a8,5000).
p(a12,4000).
p(a11,4000).
p(a2,9000).
p(a7,7000).
p(a19,1000).
p(a6,3000).
p(a3,8000).
p(a4,8000).
p(a10,3000).
p(a13,5000).
p(a16,4000).
p(a14,3000).
p(a5,3000).
p(a0,1000).
p(a17,5000).
p(a15,2000).
p(a18,2000).
p(a1,6000).
p(a9,1000).
att(a8,a11).
att(a8,a12).
att(a12,a8).
att(a12,a2).
att(a11,a7).
att(a2,a11).
att(a19,a2).
att(a7,a6).
att(a6,a7).
att(a19,a7).
att(a19,a3).
att(a3,a19).
att(a6,a4).
att(a6,a3).
att(a3,a10).
att(a4,a13).
att(a13,a4).
att(a4,a10).
att(a10,a16).
att(a16,a10).
att(a14,a13).
att(a13,a16).
att(a16,a13).
att(a16,a5).
att(a14,a0).
att(a5,a14).
att(a5,a17).
att(a15,a0).
att(a17,a0).
att(a17,a18).
att(a18,a17).
att(a15,a1).
att(a15,a18).
att(a18,a15).
att(a18,a9).
att(a9,a18).
att(a1,a9).
att(a9,a1).
p(0,a8,a11,6000).
p(1,a8,a12,5000).
p(2,a12,a8,5000).
p(3,a12,a2,3000).
p(4,a11,a7,3000).
p(5,a2,a11,4000).
p(6,a19,a2,3000).
p(7,a7,a6,1000).
p(8,a6,a7,5000).
p(9,a19,a7,1000).
p(10,a19,a3,6000).
p(11,a3,a19,2000).
p(12,a6,a4,2000).
p(13,a6,a3,8000).
p(14,a3,a10,9000).
p(15,a4,a13,1000).
p(16,a13,a4,6000).
p(17,a4,a10,6000).
p(18,a10,a16,6000).
p(19,a16,a10,5000).
p(20,a14,a13,3000).
p(21,a13,a16,1000).
p(22,a16,a13,4000).
p(23,a16,a5,4000).
p(24,a14,a0,8000).
p(25,a5,a14,9000).
p(26,a5,a17,3000).
p(27,a15,a0,9000).
p(28,a17,a0,7000).
p(29,a17,a18,1000).
p(30,a18,a17,7000).
p(31,a15,a1,7000).
p(32,a15,a18,8000).
p(33,a18,a15,8000).
p(34,a18,a9,9000).
p(35,a9,a18,3000).
p(36,a1,a9,4000).
p(37,a9,a1,4000).
query(a18).