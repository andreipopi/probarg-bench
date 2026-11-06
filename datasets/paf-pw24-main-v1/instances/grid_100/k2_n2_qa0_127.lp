% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=1
% probarg formalism=PAF
% probarg generator=PW24-full-grid-v1
% probarg generator_sha256=d9200c83ef88f7fa6010122c137a46d4edbd46639b62fb91cc5cff0fa9398b5e
% probarg k=2
% probarg master_seed=20261106
% probarg n=2
% probarg probability_scale=1
% probarg replicate=127
% probarg runner_sha256=23de6e43f4f7384bf7a3ffba9608f63b0652715f7a5bc36353d90db5a4da8e70
% probarg seed=5655387047626720994
% probarg source_commit=df7961a39dc666610298d7d2539ee2a8da315508
% probarg source_sha256=54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38
arg(a0).
arg(a1).
arg(a2).
arg(a3).
p(a2,0.4).
p(a0,0.8).
p(a1,0.8).
p(a3,0.7).
att(a2,a1).
att(a2,a0).
att(a0,a2).
att(a0,a3).
att(a3,a0).
att(a1,a3).
att(a3,a1).
p(0,a2,a1,0.5).
p(1,a2,a0,0.8).
p(2,a0,a2,0.2).
p(3,a0,a3,0.1).
p(4,a3,a0,0.2).
p(5,a1,a3,0.4).
p(6,a3,a1,0.9).
extension(a3).
query(a0).