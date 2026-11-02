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
p(a7,0.1).
p(a8,0.5).
p(a3,0.2).
p(a4,0.2).
p(a6,0.1).
p(a5,0.5).
p(a9,0.5).
p(a2,0.5).
p(a1,0.7).
p(a0,0.9).
att(a3,a7).
att(a7,a8).
att(a8,a7).
att(a8,a4).
att(a4,a5).
att(a6,a9).
att(a6,a5).
att(a9,a1).
att(a1,a9).
att(a9,a2).
att(a2,a0).
p(0,a3,a7,0.9).
p(1,a7,a8,0.8).
p(2,a8,a7,0.6).
p(3,a8,a4,0.3).
p(4,a4,a5,0.8).
p(5,a6,a9,0.3).
p(6,a6,a5,0.5).
p(7,a9,a1,0.1).
p(8,a1,a9,0.4).
p(9,a9,a2,0.1).
p(10,a2,a0,0.6).
extension(a2).
in(a5).
% Grid:
% ['a7', 'a8']
% ['a3', 'a4']
% ['a6', 'a5']
% ['a9', 'a2']
% ['a1', 'a0']
% Uncovered edges: [('a3', 'a4'), ('a2', 'a5'), ('a0', 'a1'), ('a3', 'a6')]
% Count uncovered: 4
% Total edges: 13
% Percentage uncovered: 30.77%
