% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=0.75
% probarg formalism=PAF
% probarg generator=PW24-original-dense-v1
% probarg generator_sha256=af3e19e91d54b12008e705fc20f912e4de71a591fecc18fa385ddc3338e8b38c
% probarg k=3
% probarg master_seed=20261105
% probarg n=2
% probarg probability_scale=10000
% probarg replicate=8
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=1896571663183046593
% probarg source_commit=df7961a39dc666610298d7d2539ee2a8da315508
% probarg source_sha256=54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38
arg(a0).
arg(a1).
arg(a2).
arg(a3).
arg(a4).
arg(a5).
p(a0,7000).
p(a5,4000).
p(a4,4000).
p(a3,6000).
p(a2,7000).
p(a1,9000).
att(a5,a2).
att(a5,a4).
att(a4,a1).
att(a1,a4).
att(a3,a2).
att(a2,a1).
p(0,a5,a2,8000).
p(1,a5,a4,5000).
p(2,a4,a1,5000).
p(3,a1,a4,3000).
p(4,a3,a2,4000).
p(5,a2,a1,3000).
query(a0).