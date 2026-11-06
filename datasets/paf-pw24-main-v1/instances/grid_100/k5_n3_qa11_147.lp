% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=1
% probarg formalism=PAF
% probarg generator=PW24-full-grid-v1
% probarg generator_sha256=d9200c83ef88f7fa6010122c137a46d4edbd46639b62fb91cc5cff0fa9398b5e
% probarg k=5
% probarg master_seed=20261106
% probarg n=3
% probarg probability_scale=1
% probarg replicate=147
% probarg runner_sha256=23de6e43f4f7384bf7a3ffba9608f63b0652715f7a5bc36353d90db5a4da8e70
% probarg seed=12292072563208577390
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
p(a0,0.2).
p(a8,0.5).
p(a9,0.9).
p(a2,0.6).
p(a14,0.8).
p(a13,0.4).
p(a7,0.9).
p(a1,0.4).
p(a6,0.8).
p(a4,0.2).
p(a12,0.2).
p(a5,0.1).
p(a10,0.8).
p(a11,0.2).
p(a3,0.3).
att(a0,a13).
att(a0,a8).
att(a8,a7).
att(a8,a9).
att(a9,a8).
att(a9,a1).
att(a9,a2).
att(a2,a9).
att(a6,a2).
att(a2,a14).
att(a14,a4).
att(a13,a12).
att(a12,a13).
att(a13,a7).
att(a5,a7).
att(a1,a7).
att(a1,a10).
att(a6,a1).
att(a6,a11).
att(a6,a4).
att(a3,a4).
att(a12,a5).
att(a5,a12).
att(a5,a10).
att(a10,a5).
att(a11,a10).
att(a11,a3).
p(0,a0,a13,0.4).
p(1,a0,a8,0.9).
p(2,a8,a7,0.8).
p(3,a8,a9,0.7).
p(4,a9,a8,0.3).
p(5,a9,a1,0.7).
p(6,a9,a2,0.6).
p(7,a2,a9,0.6).
p(8,a6,a2,0.1).
p(9,a2,a14,0.1).
p(10,a14,a4,0.4).
p(11,a13,a12,0.9).
p(12,a12,a13,0.7).
p(13,a13,a7,0.5).
p(14,a5,a7,0.1).
p(15,a1,a7,0.5).
p(16,a1,a10,0.5).
p(17,a6,a1,0.9).
p(18,a6,a11,0.1).
p(19,a6,a4,0.6).
p(20,a3,a4,0.8).
p(21,a12,a5,0.4).
p(22,a5,a12,0.9).
p(23,a5,a10,0.6).
p(24,a10,a5,0.8).
p(25,a11,a10,0.6).
p(26,a11,a3,0.6).
query(a11).