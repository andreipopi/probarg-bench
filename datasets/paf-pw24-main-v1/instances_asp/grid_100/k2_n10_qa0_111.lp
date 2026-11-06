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
% probarg replicate=111
% probarg runner_sha256=23de6e43f4f7384bf7a3ffba9608f63b0652715f7a5bc36353d90db5a4da8e70
% probarg seed=13521618059637442650
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
p(a1,3000).
p(a15,7000).
p(a11,2000).
p(a2,3000).
p(a3,2000).
p(a16,1000).
p(a8,5000).
p(a14,1000).
p(a12,1000).
p(a4,1000).
p(a5,6000).
p(a17,3000).
p(a0,4000).
p(a18,4000).
p(a6,4000).
p(a19,5000).
p(a13,5000).
p(a9,4000).
p(a7,5000).
p(a10,7000).
att(a1,a11).
att(a11,a1).
att(a1,a15).
att(a15,a2).
att(a2,a15).
att(a3,a11).
att(a11,a2).
att(a2,a16).
att(a16,a2).
att(a8,a3).
att(a3,a16).
att(a16,a3).
att(a16,a14).
att(a14,a16).
att(a8,a12).
att(a12,a8).
att(a8,a14).
att(a14,a8).
att(a14,a4).
att(a4,a14).
att(a12,a5).
att(a5,a12).
att(a12,a4).
att(a4,a12).
att(a17,a4).
att(a0,a5).
att(a17,a5).
att(a17,a18).
att(a18,a17).
att(a6,a0).
att(a0,a18).
att(a18,a19).
att(a19,a18).
att(a13,a6).
att(a19,a6).
att(a9,a19).
att(a13,a7).
att(a7,a13).
att(a9,a13).
att(a10,a9).
att(a7,a10).
att(a10,a7).
p(0,a1,a11,1000).
p(1,a11,a1,3000).
p(2,a1,a15,2000).
p(3,a15,a2,8000).
p(4,a2,a15,8000).
p(5,a3,a11,9000).
p(6,a11,a2,2000).
p(7,a2,a16,8000).
p(8,a16,a2,1000).
p(9,a8,a3,4000).
p(10,a3,a16,8000).
p(11,a16,a3,6000).
p(12,a16,a14,2000).
p(13,a14,a16,7000).
p(14,a8,a12,8000).
p(15,a12,a8,1000).
p(16,a8,a14,5000).
p(17,a14,a8,1000).
p(18,a14,a4,1000).
p(19,a4,a14,6000).
p(20,a12,a5,9000).
p(21,a5,a12,1000).
p(22,a12,a4,1000).
p(23,a4,a12,3000).
p(24,a17,a4,1000).
p(25,a0,a5,8000).
p(26,a17,a5,6000).
p(27,a17,a18,3000).
p(28,a18,a17,7000).
p(29,a6,a0,2000).
p(30,a0,a18,8000).
p(31,a18,a19,1000).
p(32,a19,a18,1000).
p(33,a13,a6,9000).
p(34,a19,a6,2000).
p(35,a9,a19,5000).
p(36,a13,a7,7000).
p(37,a7,a13,8000).
p(38,a9,a13,4000).
p(39,a10,a9,7000).
p(40,a7,a10,6000).
p(41,a10,a7,1000).
query(a0).