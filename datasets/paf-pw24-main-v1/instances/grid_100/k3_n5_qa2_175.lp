% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=1
% probarg formalism=PAF
% probarg generator=PW24-full-grid-v1
% probarg generator_sha256=d9200c83ef88f7fa6010122c137a46d4edbd46639b62fb91cc5cff0fa9398b5e
% probarg k=3
% probarg master_seed=20261106
% probarg n=5
% probarg probability_scale=1
% probarg replicate=175
% probarg runner_sha256=23de6e43f4f7384bf7a3ffba9608f63b0652715f7a5bc36353d90db5a4da8e70
% probarg seed=3201006641255213211
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
p(a11,0.2).
p(a2,0.3).
p(a10,0.8).
p(a5,0.1).
p(a0,0.5).
p(a1,0.6).
p(a3,0.6).
p(a14,0.3).
p(a8,0.6).
p(a4,0.3).
p(a13,0.8).
p(a9,0.1).
p(a6,0.6).
p(a7,0.8).
p(a12,0.5).
att(a5,a11).
att(a11,a2).
att(a2,a11).
att(a2,a0).
att(a0,a2).
att(a10,a2).
att(a10,a1).
att(a1,a10).
att(a3,a5).
att(a5,a0).
att(a0,a14).
att(a14,a0).
att(a1,a0).
att(a1,a8).
att(a8,a1).
att(a4,a3).
att(a3,a14).
att(a14,a13).
att(a8,a14).
att(a8,a9).
att(a9,a8).
att(a4,a6).
att(a13,a4).
att(a13,a7).
att(a13,a9).
att(a9,a13).
att(a12,a9).
att(a6,a7).
att(a7,a12).
p(0,a5,a11,0.7).
p(1,a11,a2,0.4).
p(2,a2,a11,0.7).
p(3,a2,a0,0.6).
p(4,a0,a2,0.9).
p(5,a10,a2,0.8).
p(6,a10,a1,0.1).
p(7,a1,a10,0.8).
p(8,a3,a5,0.7).
p(9,a5,a0,0.6).
p(10,a0,a14,0.1).
p(11,a14,a0,0.7).
p(12,a1,a0,0.9).
p(13,a1,a8,0.8).
p(14,a8,a1,0.6).
p(15,a4,a3,0.8).
p(16,a3,a14,0.9).
p(17,a14,a13,0.9).
p(18,a8,a14,0.2).
p(19,a8,a9,0.2).
p(20,a9,a8,0.5).
p(21,a4,a6,0.6).
p(22,a13,a4,0.1).
p(23,a13,a7,0.2).
p(24,a13,a9,0.3).
p(25,a9,a13,0.7).
p(26,a12,a9,0.1).
p(27,a6,a7,0.1).
p(28,a7,a12,0.9).
query(a2).