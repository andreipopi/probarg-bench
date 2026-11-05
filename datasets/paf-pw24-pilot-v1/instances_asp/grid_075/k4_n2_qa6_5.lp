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
% probarg replicate=5
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=8948704292402924592
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
p(a0,6000).
p(a1,6000).
p(a5,7000).
p(a6,5000).
p(a3,3000).
p(a4,3000).
p(a2,9000).
p(a7,4000).
att(a0,a3).
att(a3,a0).
att(a0,a1).
att(a4,a1).
att(a1,a5).
att(a2,a5).
att(a6,a7).
att(a7,a6).
att(a3,a4).
att(a4,a3).
att(a2,a7).
p(0,a0,a3,7000).
p(1,a3,a0,9000).
p(2,a0,a1,5000).
p(3,a4,a1,5000).
p(4,a1,a5,2000).
p(5,a2,a5,1000).
p(6,a6,a7,4000).
p(7,a7,a6,2000).
p(8,a3,a4,5000).
p(9,a4,a3,7000).
p(10,a2,a7,9000).
extension(a2).
query(a6).