% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=1
% probarg formalism=PAF
% probarg generator=PW24-full-grid-v1
% probarg generator_sha256=d9200c83ef88f7fa6010122c137a46d4edbd46639b62fb91cc5cff0fa9398b5e
% probarg k=6
% probarg master_seed=20261106
% probarg n=2
% probarg probability_scale=1
% probarg replicate=372
% probarg runner_sha256=23de6e43f4f7384bf7a3ffba9608f63b0652715f7a5bc36353d90db5a4da8e70
% probarg seed=1580406140427165552
% probarg source_commit=df7961a39dc666610298d7d2539ee2a8da315508
% probarg source_sha256=54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38
arg(a0).
arg(a1).
arg(a10).
arg(a11).
arg(a2).
arg(a3).
arg(a4).
arg(a5).
arg(a6).
arg(a7).
arg(a8).
arg(a9).
p(a10,0.5).
p(a4,0.3).
p(a3,0.7).
p(a0,1).
p(a1,0.2).
p(a9,0.8).
p(a8,0.7).
p(a7,0.1).
p(a6,0.2).
p(a11,0.3).
p(a2,0.6).
p(a5,0.2).
att(a8,a10).
att(a4,a10).
att(a7,a4).
att(a3,a4).
att(a3,a6).
att(a6,a3).
att(a0,a3).
att(a0,a11).
att(a11,a0).
att(a0,a1).
att(a1,a0).
att(a2,a1).
att(a1,a9).
att(a5,a9).
att(a8,a7).
att(a7,a6).
att(a6,a7).
att(a6,a11).
att(a11,a2).
att(a2,a5).
att(a5,a2).
p(0,a8,a10,0.2).
p(1,a4,a10,0.9).
p(2,a7,a4,0.7).
p(3,a3,a4,0.6).
p(4,a3,a6,0.5).
p(5,a6,a3,0.6).
p(6,a0,a3,0.5).
p(7,a0,a11,0.4).
p(8,a11,a0,0.2).
p(9,a0,a1,0.5).
p(10,a1,a0,0.7).
p(11,a2,a1,0.8).
p(12,a1,a9,0.4).
p(13,a5,a9,0.2).
p(14,a8,a7,0.1).
p(15,a7,a6,0.6).
p(16,a6,a7,0.2).
p(17,a6,a11,0.1).
p(18,a11,a2,0.3).
p(19,a2,a5,0.1).
p(20,a5,a2,0.9).
extension(a3).
extension(a9).
query(a11).