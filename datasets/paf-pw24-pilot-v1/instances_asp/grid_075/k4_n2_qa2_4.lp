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
% probarg replicate=4
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=18044311129131840904
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
p(a1,7000).
p(a6,6000).
p(a2,4000).
p(a3,2000).
p(a5,5000).
p(a0,5000).
p(a4,9000).
p(a7,6000).
att(a5,a1).
att(a6,a1).
att(a2,a4).
att(a4,a2).
att(a2,a3).
att(a3,a2).
att(a3,a7).
att(a7,a4).
p(0,a5,a1,8000).
p(1,a6,a1,1000).
p(2,a2,a4,7000).
p(3,a4,a2,3000).
p(4,a2,a3,5000).
p(5,a3,a2,5000).
p(6,a3,a7,8000).
p(7,a7,a4,1000).
query(a2).