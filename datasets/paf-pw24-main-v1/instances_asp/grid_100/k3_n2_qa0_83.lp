% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=1
% probarg formalism=PAF
% probarg generator=PW24-full-grid-v1
% probarg generator_sha256=d9200c83ef88f7fa6010122c137a46d4edbd46639b62fb91cc5cff0fa9398b5e
% probarg k=3
% probarg master_seed=20261106
% probarg n=2
% probarg probability_scale=10000
% probarg replicate=83
% probarg runner_sha256=23de6e43f4f7384bf7a3ffba9608f63b0652715f7a5bc36353d90db5a4da8e70
% probarg seed=5115911091386957487
% probarg source_commit=df7961a39dc666610298d7d2539ee2a8da315508
% probarg source_sha256=54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38
arg(a0).
arg(a1).
arg(a2).
arg(a3).
arg(a4).
arg(a5).
p(a5,9000).
p(a2,3000).
p(a0,2000).
p(a3,3000).
p(a1,5000).
p(a4,6000).
att(a3,a5).
att(a5,a2).
att(a2,a1).
att(a1,a2).
att(a2,a0).
att(a0,a4).
att(a3,a1).
att(a4,a1).
p(0,a3,a5,9000).
p(1,a5,a2,8000).
p(2,a2,a1,6000).
p(3,a1,a2,7000).
p(4,a2,a0,2000).
p(5,a0,a4,9000).
p(6,a3,a1,7000).
p(7,a4,a1,4000).
query(a0).