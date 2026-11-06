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
% probarg replicate=202
% probarg runner_sha256=23de6e43f4f7384bf7a3ffba9608f63b0652715f7a5bc36353d90db5a4da8e70
% probarg seed=4926165397455330763
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
p(a9,1000).
p(a5,9000).
p(a19,4000).
p(a8,8000).
p(a12,9000).
p(a17,4000).
p(a11,1000).
p(a16,9000).
p(a0,4000).
p(a4,1000).
p(a7,8000).
p(a14,2000).
p(a6,1000).
p(a15,8000).
p(a2,9000).
p(a3,2000).
p(a13,8000).
p(a1,4000).
p(a10,3000).
p(a18,9000).
att(a9,a19).
att(a9,a5).
att(a8,a5).
att(a19,a12).
att(a12,a19).
att(a8,a19).
att(a8,a17).
att(a12,a11).
att(a12,a17).
att(a17,a16).
att(a16,a17).
att(a0,a11).
att(a11,a16).
att(a4,a16).
att(a0,a7).
att(a4,a0).
att(a14,a4).
att(a7,a6).
att(a6,a7).
att(a7,a14).
att(a15,a14).
att(a2,a6).
att(a15,a6).
att(a15,a3).
att(a2,a13).
att(a13,a2).
att(a2,a3).
att(a3,a2).
att(a3,a1).
att(a1,a3).
att(a13,a10).
att(a13,a1).
att(a1,a13).
att(a1,a18).
att(a10,a18).
att(a18,a10).
p(0,a9,a19,9000).
p(1,a9,a5,2000).
p(2,a8,a5,6000).
p(3,a19,a12,1000).
p(4,a12,a19,3000).
p(5,a8,a19,9000).
p(6,a8,a17,4000).
p(7,a12,a11,5000).
p(8,a12,a17,4000).
p(9,a17,a16,5000).
p(10,a16,a17,1000).
p(11,a0,a11,5000).
p(12,a11,a16,3000).
p(13,a4,a16,2000).
p(14,a0,a7,4000).
p(15,a4,a0,2000).
p(16,a14,a4,9000).
p(17,a7,a6,4000).
p(18,a6,a7,4000).
p(19,a7,a14,3000).
p(20,a15,a14,4000).
p(21,a2,a6,3000).
p(22,a15,a6,9000).
p(23,a15,a3,9000).
p(24,a2,a13,6000).
p(25,a13,a2,2000).
p(26,a2,a3,8000).
p(27,a3,a2,4000).
p(28,a3,a1,6000).
p(29,a1,a3,3000).
p(30,a13,a10,8000).
p(31,a13,a1,3000).
p(32,a1,a13,6000).
p(33,a1,a18,3000).
p(34,a10,a18,4000).
p(35,a18,a10,1000).
query(a18).