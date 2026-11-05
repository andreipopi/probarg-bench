% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=0.75
% probarg formalism=PAF
% probarg generator=PW24-original-dense-v1
% probarg generator_sha256=af3e19e91d54b12008e705fc20f912e4de71a591fecc18fa385ddc3338e8b38c
% probarg k=2
% probarg master_seed=20261105
% probarg n=2
% probarg probability_scale=1
% probarg replicate=4
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=17060254867559662387
% probarg source_commit=df7961a39dc666610298d7d2539ee2a8da315508
% probarg source_sha256=54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38
arg(a0).
arg(a1).
arg(a2).
arg(a3).
p(a3,0.8).
p(a1,0.7).
p(a2,0.9).
p(a0,0.7).
att(a3,a2).
att(a2,a3).
att(a0,a1).
att(a0,a2).
p(0,a3,a2,0.1).
p(1,a2,a3,0.3).
p(2,a0,a1,0.8).
p(3,a0,a2,0.2).
query(a0).