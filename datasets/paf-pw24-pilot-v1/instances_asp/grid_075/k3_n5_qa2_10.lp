% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=0.75
% probarg formalism=PAF
% probarg generator=PW24-original-dense-v1
% probarg generator_sha256=af3e19e91d54b12008e705fc20f912e4de71a591fecc18fa385ddc3338e8b38c
% probarg k=3
% probarg master_seed=20261105
% probarg n=5
% probarg probability_scale=10000
% probarg replicate=10
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=10887313746610733103
% probarg source_commit=df7961a39dc666610298d7d2539ee2a8da315508
% probarg source_sha256=54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38
arg(a0).
arg(a1).
arg(a10).
arg(a11).
arg(a12).
arg(a13).
arg(a14).
arg(a2).
arg(a3).
arg(a4).
arg(a5).
arg(a6).
arg(a7).
arg(a8).
arg(a9).
p(a5,7000).
p(a13,5000).
p(a10,2000).
p(a12,7000).
p(a14,3000).
p(a0,8000).
p(a11,9000).
p(a8,5000).
p(a3,5000).
p(a7,8000).
p(a9,7000).
p(a6,8000).
p(a2,6000).
p(a1,5000).
p(a4,2000).
att(a13,a5).
att(a10,a13).
att(a0,a10).
att(a11,a12).
att(a12,a14).
att(a14,a8).
att(a0,a14).
att(a3,a0).
att(a11,a7).
att(a7,a11).
att(a11,a8).
att(a8,a11).
att(a8,a9).
att(a9,a8).
att(a6,a3).
att(a2,a7).
att(a7,a9).
att(a9,a7).
att(a4,a6).
att(a1,a2).
p(0,a13,a5,8000).
p(1,a10,a13,8000).
p(2,a0,a10,4000).
p(3,a11,a12,2000).
p(4,a12,a14,4000).
p(5,a14,a8,4000).
p(6,a0,a14,9000).
p(7,a3,a0,7000).
p(8,a11,a7,8000).
p(9,a7,a11,2000).
p(10,a11,a8,2000).
p(11,a8,a11,8000).
p(12,a8,a9,8000).
p(13,a9,a8,9000).
p(14,a6,a3,5000).
p(15,a2,a7,5000).
p(16,a7,a9,5000).
p(17,a9,a7,4000).
p(18,a4,a6,5000).
p(19,a1,a2,6000).
extension(a14).
extension(a9).
query(a2).