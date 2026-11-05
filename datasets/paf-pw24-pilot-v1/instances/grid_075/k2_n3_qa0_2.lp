% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=0.75
% probarg formalism=PAF
% probarg generator=PW24-original-dense-v1
% probarg generator_sha256=af3e19e91d54b12008e705fc20f912e4de71a591fecc18fa385ddc3338e8b38c
% probarg k=2
% probarg master_seed=20261105
% probarg n=3
% probarg probability_scale=1
% probarg replicate=2
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=10290605248843751034
% probarg source_commit=df7961a39dc666610298d7d2539ee2a8da315508
% probarg source_sha256=54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38
arg(a0).
arg(a1).
arg(a2).
arg(a3).
arg(a4).
arg(a5).
p(a4,0.4).
p(a1,0.4).
p(a3,0.6).
p(a5,0.6).
p(a0,0.8).
p(a2,0.7).
att(a3,a4).
att(a4,a1).
att(a1,a4).
att(a3,a0).
att(a0,a3).
att(a5,a3).
att(a5,a2).
att(a0,a2).
p(0,a3,a4,0.3).
p(1,a4,a1,0.3).
p(2,a1,a4,0.7).
p(3,a3,a0,0.7).
p(4,a0,a3,0.8).
p(5,a5,a3,0.6).
p(6,a5,a2,0.6).
p(7,a0,a2,0.3).
query(a0).