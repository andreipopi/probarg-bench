% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=1
% probarg formalism=PAF
% probarg generator=PW24-full-grid-v1
% probarg generator_sha256=d9200c83ef88f7fa6010122c137a46d4edbd46639b62fb91cc5cff0fa9398b5e
% probarg k=2
% probarg master_seed=20261106
% probarg n=2
% probarg probability_scale=10000
% probarg replicate=330
% probarg runner_sha256=23de6e43f4f7384bf7a3ffba9608f63b0652715f7a5bc36353d90db5a4da8e70
% probarg seed=9938014481430206918
% probarg source_commit=df7961a39dc666610298d7d2539ee2a8da315508
% probarg source_sha256=54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38
arg(a0).
arg(a1).
arg(a2).
arg(a3).
p(a1,4000).
p(a3,8000).
p(a2,7000).
p(a0,6000).
att(a2,a1).
att(a1,a3).
att(a0,a3).
att(a2,a0).
p(0,a2,a1,1000).
p(1,a1,a3,6000).
p(2,a0,a3,6000).
p(3,a2,a0,4000).
query(a0).