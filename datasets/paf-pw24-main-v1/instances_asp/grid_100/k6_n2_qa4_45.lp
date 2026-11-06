% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=1
% probarg formalism=PAF
% probarg generator=PW24-full-grid-v1
% probarg generator_sha256=d9200c83ef88f7fa6010122c137a46d4edbd46639b62fb91cc5cff0fa9398b5e
% probarg k=6
% probarg master_seed=20261106
% probarg n=2
% probarg probability_scale=10000
% probarg replicate=45
% probarg runner_sha256=23de6e43f4f7384bf7a3ffba9608f63b0652715f7a5bc36353d90db5a4da8e70
% probarg seed=8901424877370484909
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
p(a9,3000).
p(a7,2000).
p(a2,4000).
p(a3,7000).
p(a11,8000).
p(a5,8000).
p(a1,9000).
p(a4,6000).
p(a8,4000).
p(a6,6000).
p(a10,9000).
p(a0,6000).
att(a1,a9).
att(a9,a7).
att(a7,a9).
att(a7,a4).
att(a4,a7).
att(a7,a2).
att(a2,a8).
att(a8,a2).
att(a3,a2).
att(a6,a3).
att(a3,a11).
att(a11,a3).
att(a10,a11).
att(a11,a5).
att(a5,a0).
att(a1,a4).
att(a4,a1).
att(a4,a8).
att(a6,a8).
att(a6,a10).
att(a10,a6).
att(a0,a10).
p(0,a1,a9,9000).
p(1,a9,a7,4000).
p(2,a7,a9,5000).
p(3,a7,a4,8000).
p(4,a4,a7,2000).
p(5,a7,a2,6000).
p(6,a2,a8,1000).
p(7,a8,a2,3000).
p(8,a3,a2,8000).
p(9,a6,a3,7000).
p(10,a3,a11,5000).
p(11,a11,a3,1000).
p(12,a10,a11,9000).
p(13,a11,a5,7000).
p(14,a5,a0,9000).
p(15,a1,a4,6000).
p(16,a4,a1,3000).
p(17,a4,a8,5000).
p(18,a6,a8,9000).
p(19,a6,a10,4000).
p(20,a10,a6,2000).
p(21,a0,a10,2000).
query(a4).