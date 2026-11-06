arg(a0).
arg(a1).
arg(a2).
arg(a3).
arg(a4).
arg(a5).
arg(a6).
arg(a7).
arg(a8).
arg(a9).
p(a3,0.5).
p(a6,0.8).
p(a4,0.9).
p(a8,0.6).
p(a0,0.8).
p(a9,0.8).
p(a1,0.7).
p(a5,0.1).
p(a7,0.7).
p(a2,0.6).
att(a3,a4).
att(a6,a3).
att(a6,a8).
att(a8,a6).
att(a4,a0).
att(a8,a4).
att(a8,a9).
att(a9,a8).
att(a0,a1).
att(a1,a0).
att(a9,a0).
att(a1,a7).
att(a7,a1).
att(a5,a1).
att(a2,a5).
p(0,a3,a4,0.6).
p(1,a6,a3,0.2).
p(2,a6,a8,0.5).
p(3,a8,a6,0.6).
p(4,a4,a0,0.8).
p(5,a8,a4,0.9).
p(6,a8,a9,0.1).
p(7,a9,a8,0.3).
p(8,a0,a1,0.1).
p(9,a1,a0,0.4).
p(10,a9,a0,0.4).
p(11,a1,a7,0.4).
p(12,a7,a1,0.5).
p(13,a5,a1,0.4).
p(14,a2,a5,0.5).
in(a2).
% Grid:
% ['a3', 'a6']
% ['a4', 'a8']
% ['a0', 'a9']
% ['a1', 'a5']
% ['a7', 'a2']
% Uncovered edges: [('a2', 'a7'), ('a5', 'a9')]
% Count uncovered: 2
% Total edges: 13
% Percentage uncovered: 15.38%
