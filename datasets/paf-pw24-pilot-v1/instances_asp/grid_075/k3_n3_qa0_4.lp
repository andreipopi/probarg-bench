% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=0.75
% probarg formalism=PAF
% probarg generator=PW24-original-dense-v1
% probarg generator_sha256=af3e19e91d54b12008e705fc20f912e4de71a591fecc18fa385ddc3338e8b38c
% probarg k=3
% probarg master_seed=20261105
% probarg n=3
% probarg probability_scale=10000
% probarg replicate=4
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=3395585648413846173
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
p(a7,6000).
p(a1,4000).
p(a5,1000).
p(a0,8000).
p(a6,9000).
p(a4,2000).
p(a3,6000).
p(a2,8000).
p(a8,3000).
att(a0,a7).
att(a7,a1).
att(a1,a6).
att(a6,a1).
att(a5,a4).
att(a0,a3).
att(a0,a6).
att(a2,a6).
att(a4,a8).
att(a8,a2).
p(0,a0,a7,1000).
p(1,a7,a1,8000).
p(2,a1,a6,6000).
p(3,a6,a1,6000).
p(4,a5,a4,6000).
p(5,a0,a3,4000).
p(6,a0,a6,6000).
p(7,a2,a6,6000).
p(8,a4,a8,8000).
p(9,a8,a2,8000).
query(a0).