% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=0.75
% probarg formalism=PAF
% probarg generator=PW24-original-dense-v1
% probarg generator_sha256=af3e19e91d54b12008e705fc20f912e4de71a591fecc18fa385ddc3338e8b38c
% probarg k=4
% probarg master_seed=20261105
% probarg n=2
% probarg probability_scale=10000
% probarg replicate=7
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=11810639518541929098
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
p(a7,8000).
p(a4,3000).
p(a3,4000).
p(a1,7000).
p(a5,3000).
p(a0,7000).
p(a6,9000).
p(a2,3000).
att(a7,a5).
att(a7,a4).
att(a4,a7).
att(a4,a0).
att(a3,a4).
att(a6,a3).
att(a1,a2).
att(a0,a6).
att(a6,a2).
p(0,a7,a5,9000).
p(1,a7,a4,5000).
p(2,a4,a7,8000).
p(3,a4,a0,8000).
p(4,a3,a4,6000).
p(5,a6,a3,3000).
p(6,a1,a2,7000).
p(7,a0,a6,2000).
p(8,a6,a2,4000).
query(a0).