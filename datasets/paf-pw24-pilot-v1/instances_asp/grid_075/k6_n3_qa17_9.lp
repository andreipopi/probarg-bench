% probarg candidate_probability=0.04
% probarg certainty_weight=0.1
% probarg edge_probability=0.75
% probarg formalism=PAF
% probarg generator=PW24-original-dense-v1
% probarg generator_sha256=af3e19e91d54b12008e705fc20f912e4de71a591fecc18fa385ddc3338e8b38c
% probarg k=6
% probarg master_seed=20261105
% probarg n=3
% probarg probability_scale=10000
% probarg replicate=9
% probarg runner_sha256=2b327730befc9610a69435eabec656d566898e01e6ca810ee0826ee9fbcd6186
% probarg seed=11313530043450730052
% probarg source_commit=df7961a39dc666610298d7d2539ee2a8da315508
% probarg source_sha256=54e38b700c2409f193f3c94cb2a798fe6ccfdcf27a7e73eeedcdd7404efa5a38
arg(a0).
arg(a1).
arg(a10).
arg(a11).
arg(a12).
arg(a13).
arg(a14).
arg(a15).
arg(a16).
arg(a17).
arg(a2).
arg(a3).
arg(a4).
arg(a5).
arg(a6).
arg(a7).
arg(a8).
arg(a9).
p(a10,3000).
p(a17,8000).
p(a13,3000).
p(a16,1000).
p(a6,8000).
p(a5,5000).
p(a12,6000).
p(a11,6000).
p(a15,6000).
p(a0,8000).
p(a2,1000).
p(a3,2000).
p(a7,3000).
p(a8,2000).
p(a14,1000).
p(a4,6000).
p(a9,1000).
p(a1,8000).
att(a12,a10).
att(a10,a17).
att(a17,a13).
att(a13,a17).
att(a16,a13).
att(a0,a16).
att(a5,a6).
att(a12,a7).
att(a7,a12).
att(a8,a11).
att(a15,a11).
att(a15,a14).
att(a4,a0).
att(a0,a2).
att(a2,a0).
att(a9,a2).
att(a2,a3).
att(a7,a8).
att(a8,a14).
att(a14,a8).
att(a4,a9).
att(a9,a1).
p(0,a12,a10,8000).
p(1,a10,a17,4000).
p(2,a17,a13,5000).
p(3,a13,a17,8000).
p(4,a16,a13,9000).
p(5,a0,a16,8000).
p(6,a5,a6,5000).
p(7,a12,a7,2000).
p(8,a7,a12,5000).
p(9,a8,a11,4000).
p(10,a15,a11,1000).
p(11,a15,a14,1000).
p(12,a4,a0,1000).
p(13,a0,a2,5000).
p(14,a2,a0,8000).
p(15,a9,a2,3000).
p(16,a2,a3,6000).
p(17,a7,a8,4000).
p(18,a8,a14,6000).
p(19,a14,a8,3000).
p(20,a4,a9,1000).
p(21,a9,a1,1000).
extension(a11).
query(a17).