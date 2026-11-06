% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=1
% probarg formalism=PAF
% probarg generator=PW24-full-grid-v1
% probarg generator_sha256=d9200c83ef88f7fa6010122c137a46d4edbd46639b62fb91cc5cff0fa9398b5e
% probarg k=3
% probarg master_seed=20261106
% probarg n=3
% probarg probability_scale=1
% probarg replicate=309
% probarg runner_sha256=23de6e43f4f7384bf7a3ffba9608f63b0652715f7a5bc36353d90db5a4da8e70
% probarg seed=9082003907935011465
% probarg source_commit=df7961a39dc666610298d7d2539ee2a8da315508
% probarg source_sha256=54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38
arg(a0).
arg(a1).
arg(a2).
arg(a3).
arg(a4).
arg(a5).
arg(a6).
arg(a7).
arg(a8).
p(a4,0.8).
p(a8,0.3).
p(a7,0.8).
p(a2,0.6).
p(a0,0.6).
p(a3,0.1).
p(a1,0.9).
p(a5,0.7).
p(a6,0.7).
att(a4,a2).
att(a8,a4).
att(a0,a8).
att(a8,a7).
att(a7,a8).
att(a7,a3).
att(a2,a1).
att(a1,a2).
att(a0,a2).
att(a5,a0).
att(a3,a0).
att(a3,a6).
att(a6,a3).
att(a1,a5).
att(a5,a6).
att(a6,a5).
p(0,a4,a2,0.1).
p(1,a8,a4,0.7).
p(2,a0,a8,0.6).
p(3,a8,a7,0.8).
p(4,a7,a8,0.9).
p(5,a7,a3,0.4).
p(6,a2,a1,0.6).
p(7,a1,a2,0.5).
p(8,a0,a2,0.6).
p(9,a5,a0,0.4).
p(10,a3,a0,0.6).
p(11,a3,a6,0.9).
p(12,a6,a3,0.6).
p(13,a1,a5,0.3).
p(14,a5,a6,0.8).
p(15,a6,a5,0.8).
extension(a7).
query(a8).