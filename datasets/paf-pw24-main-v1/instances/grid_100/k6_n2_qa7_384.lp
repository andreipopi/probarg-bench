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
% probarg replicate=384
% probarg runner_sha256=23de6e43f4f7384bf7a3ffba9608f63b0652715f7a5bc36353d90db5a4da8e70
% probarg seed=5364357397188008658
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
p(a7,0.2).
p(a6,0.3).
p(a11,0.6).
p(a5,0.8).
p(a9,0.9).
p(a4,0.3).
p(a0,0.5).
p(a10,0.8).
p(a8,0.7).
p(a2,0.5).
p(a1,0.2).
p(a3,0.9).
att(a7,a0).
att(a6,a7).
att(a6,a10).
att(a6,a11).
att(a11,a8).
att(a11,a5).
att(a2,a5).
att(a9,a5).
att(a9,a1).
att(a9,a4).
att(a4,a3).
att(a0,a10).
att(a10,a8).
att(a8,a2).
att(a1,a2).
att(a1,a3).
att(a3,a1).
p(0,a7,a0,0.9).
p(1,a6,a7,0.5).
p(2,a6,a10,0.4).
p(3,a6,a11,0.1).
p(4,a11,a8,0.5).
p(5,a11,a5,0.6).
p(6,a2,a5,0.3).
p(7,a9,a5,0.7).
p(8,a9,a1,0.3).
p(9,a9,a4,0.3).
p(10,a4,a3,0.3).
p(11,a0,a10,0.1).
p(12,a10,a8,0.2).
p(13,a8,a2,0.7).
p(14,a1,a2,0.6).
p(15,a1,a3,0.2).
p(16,a3,a1,0.8).
query(a7).