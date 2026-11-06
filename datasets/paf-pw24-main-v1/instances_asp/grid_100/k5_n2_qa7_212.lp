% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=1
% probarg formalism=PAF
% probarg generator=PW24-full-grid-v1
% probarg generator_sha256=d9200c83ef88f7fa6010122c137a46d4edbd46639b62fb91cc5cff0fa9398b5e
% probarg k=5
% probarg master_seed=20261106
% probarg n=2
% probarg probability_scale=10000
% probarg replicate=212
% probarg runner_sha256=23de6e43f4f7384bf7a3ffba9608f63b0652715f7a5bc36353d90db5a4da8e70
% probarg seed=11569944057499755263
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
arg(a9).
p(a4,8000).
p(a1,3000).
p(a7,9000).
p(a2,6000).
p(a0,1000).
p(a8,9000).
p(a3,9000).
p(a6,5000).
p(a9,6000).
p(a5,8000).
att(a4,a8).
att(a1,a4).
att(a3,a1).
att(a1,a7).
att(a6,a7).
att(a7,a2).
att(a2,a9).
att(a9,a2).
att(a2,a0).
att(a0,a2).
att(a0,a5).
att(a5,a0).
att(a3,a8).
att(a3,a6).
att(a9,a6).
att(a5,a9).
p(0,a4,a8,7000).
p(1,a1,a4,7000).
p(2,a3,a1,3000).
p(3,a1,a7,6000).
p(4,a6,a7,2000).
p(5,a7,a2,4000).
p(6,a2,a9,7000).
p(7,a9,a2,6000).
p(8,a2,a0,7000).
p(9,a0,a2,1000).
p(10,a0,a5,4000).
p(11,a5,a0,5000).
p(12,a3,a8,8000).
p(13,a3,a6,1000).
p(14,a9,a6,9000).
p(15,a5,a9,1000).
query(a7).