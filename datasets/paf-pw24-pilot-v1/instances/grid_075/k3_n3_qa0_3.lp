% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=0.75
% probarg formalism=PAF
% probarg generator=PW24-original-dense-v1
% probarg generator_sha256=af3e19e91d54b12008e705fc20f912e4de71a591fecc18fa385ddc3338e8b38c
% probarg k=3
% probarg master_seed=20261105
% probarg n=3
% probarg probability_scale=1
% probarg replicate=3
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=1358783289816846768
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
p(a6,0.4).
p(a4,0.5).
p(a2,0.9).
p(a8,0.4).
p(a1,0.9).
p(a0,0.2).
p(a7,0.4).
p(a5,0.4).
p(a3,0.9).
att(a6,a8).
att(a8,a6).
att(a1,a4).
att(a4,a2).
att(a2,a0).
att(a0,a1).
att(a0,a3).
att(a7,a5).
att(a5,a3).
att(a3,a5).
p(0,a6,a8,0.3).
p(1,a8,a6,0.6).
p(2,a1,a4,0.7).
p(3,a4,a2,0.1).
p(4,a2,a0,0.2).
p(5,a0,a1,0.2).
p(6,a0,a3,0.6).
p(7,a7,a5,0.7).
p(8,a5,a3,0.3).
p(9,a3,a5,0.6).
extension(a1).
query(a0).