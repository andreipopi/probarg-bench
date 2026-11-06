% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=1
% probarg formalism=PAF
% probarg generator=PW24-full-grid-v1
% probarg generator_sha256=d9200c83ef88f7fa6010122c137a46d4edbd46639b62fb91cc5cff0fa9398b5e
% probarg k=2
% probarg master_seed=20261106
% probarg n=3
% probarg probability_scale=1
% probarg replicate=269
% probarg runner_sha256=23de6e43f4f7384bf7a3ffba9608f63b0652715f7a5bc36353d90db5a4da8e70
% probarg seed=17084936817235126109
% probarg source_commit=df7961a39dc666610298d7d2539ee2a8da315508
% probarg source_sha256=54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38
arg(a0).
arg(a1).
arg(a2).
arg(a3).
arg(a4).
arg(a5).
p(a0,0.3).
p(a3,0.9).
p(a1,0.3).
p(a2,0.6).
p(a4,0.2).
p(a5,0.7).
att(a1,a0).
att(a3,a0).
att(a2,a3).
att(a4,a1).
att(a1,a2).
att(a2,a5).
att(a5,a2).
att(a4,a5).
att(a5,a4).
p(0,a1,a0,0.3).
p(1,a3,a0,0.5).
p(2,a2,a3,0.4).
p(3,a4,a1,0.6).
p(4,a1,a2,0.7).
p(5,a2,a5,0.1).
p(6,a5,a2,0.3).
p(7,a4,a5,0.8).
p(8,a5,a4,0.6).
query(a3).