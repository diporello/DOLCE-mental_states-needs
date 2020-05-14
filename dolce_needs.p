
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%An ontology of needs as mental states 
%Based on DOLCE : http://www.loa.istc.cnr.it/dolce/overview.html
%Developed by Daniele Porello with contributions by Luca Biccheri and Roberta Ferrario.

%Proved consistent with Darwin 1.4.4 using the Hets https://github.com/spechub/Hets

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Taxonomy (excerpt from the taxonomy of DOLCE)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%pt : particulars, top-level category.
%per : perdurants
%end : endurants
%con : concepts, cf. DOLCE-core, Borgo and Masolo, "Foundational Choices in Dolce",  2008.
%time : time intervals

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fof(ax_top_level, axiom, (![X]: (per(X) | (end(X) | (con(X) | time(X)))) <=> pt(X))).
fof(ax_per_end_disj, axiom, ( ~?[X]: (per(X) & end(X)))).
fof(ax_end_end_con, axiom,  ( ~?[X]: (end(X) & con(X)))).
fof(ax_con_per_con, axiom,  ( ~?[X]: (per(X) & con(X)))).
fof(ax_per_con_time, axiom, ( ~?[X]: (con(X) & time(X)))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Agents as endurants
%apo : agentive physical objects
%napo : non-agentive physcial objects
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fof(ax_top_level, axiom, (![X]: (apo(X) => end(X)))).
fof(ax_top_level, axiom, (![X]: (napo(X) => end(X)))).
fof(ax_per_apo_napo_disj, axiom, ( ~?[X]: (apo(X) & napo(X)))).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%States as perdurants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fof(ax_perdurant_partition, axiom, (![X]: ((stative(X) | event(X)) <=> per(X)))).
fof(ax_per_event_stative_disj, axiom, (  ~?[X]: (stative(X) & event(X)))).
fof(ax_states_as_stative, axiom, (![X]: (state(X) => stative(X)))).
fof(ax_processes_as_stative, axiom, (![X]: (process(X) => stative(X)))).
fof(ax_per_states_process_disj, axiom, (  ~?[X]: (state(X) & process(X)))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The relation Present at (i.e., existence at a time interval, in DOLCE)
%Every particular is present at some time interval.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fof(ax_present_at, axiom, (  ![X,T]: (presentAt(X,T) => (pt(X) & time(T))))).
fof(ax_present_at, axiom, (  ![X]: (pt(X) => ?[T]:(presentAt(X,T))))).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Participation relation (pc)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fof(ax_participation, axiom, (![X,Y,T]: (pc(X,Y,T) => (end(X) & per(Y) & time(T))))).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Classify relation CF(X,Y,T) : concept X classifies Y at t. cf. DOLCE-CORE.
%classified things at t are present at t.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fof(ax_classification, axiom, (  ![X,Y,T]: (cf(X,Y,T) => (con(X) & pt(Y) & time(T))))).
fof(ax_classification_present_at, axiom, ( ![X,Y,T]: (cf(X,Y,T) => (presentAt(Y,T))))).


%test: existence of instances:

%fof(test_existence_instances, axiom, (con(c4) & con(c3) & ~(c3 = c4) & cf(c4,a1,t1) & time(t1))).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The following axioms are new to DOLCE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mental states (ms)

%mental states are state to which a unique agent must participate (loose definition)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%mental states are states:

fof(ax_mentalstates_as_states, axiom, (![X]: (ms(X) => state(X)))).

fof(ax_mentalstates_as_states_dependent_on_agent_existence, axiom, (![X]: ((ms(X)) => ?[A,T]: (apo(A) & pc(A,X,T))))).

fof(ax_mentalstates_as_states_dependent_on_agent_unicity, axiom, (![X,T1,T2]: (ms(X) => (![A,B]: ((apo(A) & apo(B) & pc(A,X,T1) & pc(B,X,T2)) => A=B))))).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mental states (ms) and aboutness_1 and aboutness_2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%about1 (directeness)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Aboutness and present at: if a mental state is about something, it must be present.
%Mental states are always about1 a concept.
%Mental states are about at most one concept.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fof(ax_aboutenss_1_type, axiom, (![X,Y,T]: (about1(X,Y,T) => (ms(X) & con(Y) & time(T))))).

fof(ax_aboutenss_1_present, axiom, (![X,Y,T]: (about1(X,Y,T) => (presentAt(X,T) & presentAt(Y,T))))).

fof(ax_about1_existence, axiom, (![X]: (ms(X) => ?[Y,T]: (con(Y) & about1(X,Y,T))))).

fof(ax_about1_unicity_of_content1, axiom, (![X,V,W,T1,T2]:((about1(X,W,T1) & about1(X,V,T2)) => V=W))).


%about2(reference)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fof(ax_aboutenss_2_df, axiom, (![X,Z,T]: (about2(X,Z,T) <=> (ms(X) & time(T) & ?[Y]: (con(Y) & about1(X,Y,T) & cf(Y,Z,T)))))).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%$

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Intentional object and intentional content as roles.
%Intentional contents are roles of concepts.
%Intentional objects are roles of entities.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fof(ax_intentional_object_df, axiom, (![Z,T]: (intObj(Z,T) <=> ?[X]: (about2(X,Z,T))))).

fof(ax_intentional_content_df, axiom, (![Y,T]: (intCont(Y,T) <=> ?[X]: (about1(X,Y,T))))).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Belief, desire, intention, needs states as subtypes of mental states
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fof(ax_belief_states_as_states, axiom, (![X]: (belState(X) => state(X)))).

fof(ax_desire_states_as_states, axiom, (![X]: (desState(X) => state(X)))).

fof(ax_intentions_states_as_states, axiom, (![X]: (needState(X) => state(X)))).

%fof(ax_intentions_states_as_states, axiom, (![X]: (intState(X) => state(X)))).

%disjointness:

fof(ax_bel_des_disj, axiom, (  ~?[X]: (belState(X) & desState(X)))).

fof(ax_bel_int_disj, axiom, (  ~?[X]: (belState(X) & needState(X)))).

fof(ax_bel_int_disj, axiom, (  ~?[X]: (belState(X) & intState(X)))).

fof(ax_bel_int_disj, axiom, (  ~?[X]: (desState(X) & needState(X)))).

fof(ax_bel_int_disj, axiom, (  ~?[X]: (desState(X) & intState(X)))).

fof(ax_bel_int_disj, axiom, (  ~?[X]: (needState(X) & intState(X)))).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mental attitudes (bel, des, int, need0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fof(ax_beliefs_df_bel, axiom, (![A,Y,T]: (bel(A,Y,T) <=> ?[X]: (apo(A) & belState(X) & about1(X,Y,T) & pc(A,X,T))))).
fof(ax_desires_df_des, axiom, (![A,Y,T]: (des(A,Y,T) <=> ?[X]: (apo(A) & desState(X) & about1(X,Y,T) & pc(A,X,T))))).
%fof(ax_desires_df_int, axiom, (![A,Y,T]: (int(A,Y,T) <=> ?[X]: (apo(A) & intState(X) & about1(X,Y,T) & pc(A,X,T))))).
fof(ax_desires_df_need0, axiom, (![A,Y,T]: (need0(A,Y,T) <=> ?[X]: (apo(A) & needState(X) & about1(X,Y,T) & pc(A,X,T))))).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Goals
%Goals are selected desires or needs:

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fof(ax_goals_df, axiom, (![A,Y,T]: (goal(A,Y,T) <=>
        ((des(A,Y,T) | need0(A,Y,T)) & ~?[W]: (((des(A,W,T) | need0(A,W,T)) & ~?[E]: (cf(Y,E,T) & cf(W,E,T)))))))).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Instrumental and end Goals
%Satisfiers (sat(e,y,t) an event e present at t that satisfies a goal y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fof(ax_satisfier_df, axiom, (![E,Y,T]: (sat(E,Y,T) <=> (presentAt(E,T) & cf(Y,E,T))))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Time ordering:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fof(ax_time_succ_df, axiom, (![T,T1]: (succ(T,T1) => (time(T) & time(T1))))).

fof(ax_time_succ_asymm, axiom, (![T,T1]: (succ(T,T1) => ~succ(T1,T)))).

fof(ax_time_succ_irr, axiom, (![T]: (~succ(T,T)))).

fof(ax_time_succ_trans, axiom, (![T,T1,T2]: ((succ(T,T1) & succ(T1,T2)) => succ(T,T2)))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Instrumental goals (igoal)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fof(ax_igoals_df2, axiom, (![A,Y,T]: (igoal(A,Y,T) <=> (goal(A,Y,T) & ?[W,T1]: (con(W) & goal(A,W,T1) &  succ(T,T1) & (?[E]: (sat(E,Y,T) => ?[E1]: sat(E1,W,T1)))))))).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End Goals (egoal)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fof(ax_end_goals_df, axiom, (![A,Y,T]: (egoal(A,Y,T) <=> (goal(A,Y,T) & ~igoal(A,Y,T))))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Needs

%need0 : as expressing the need attitude about a content, referring to a need state.
%need1 : a need as an instrumental goals
%need2 : a need as a necessary instrumental goal.
%need3 : an absolute need, i.e. an end goal which is associated to a need state.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Need 1 as an instrumental goal:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fof(ax_need1_df, axiom, (![A,Y,T]: (need1(A,Y,T) <=> igoal(A,Y,T)))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Need 2 as a necessary instrumental goal:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fof(ax_need2_df_simple, axiom, (![A,Y,T]: (need2(A,Y,T) <=> (igoal(A,Y,T) & ?[W,T1]: (goal(A,W,T1) & succ(T,T1) & (?[E]: (sat(E,Y,T) <=> ?[E1]: sat(E1,W,T1)))))))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Need 3 as an end goal:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fof(ax_need3_df, axiom, (![A,Y,T]: (need3(A,Y,T) => (egoal(A,Y,T) & need0(A,Y,T))))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%TESTS and PROVED THEOREMS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%Tests with instances:

fof(ax_mentalstates_test_existence, axiom, (ms(s) & ms(r) & apo(a) & apo(b) & pc(a,s,t1) & pc(b,r,t2) & ~(s = r) & ~(a = b))). %Consistent
%fof(ax_mentalstates_test, axiom, ((ms(s) & apo(a) & apo(b) & pc(a,s,t1) & pc(b,s,t2)) & ~(a = b))). %Inconsistent.
fof(test_aboutenss_1_instances, axiom, ((about1(s1,c1,t1) & about1(s2,c2,t2)))). %Consistent
%fof(test_about1_unicity_of_content1, axiom, (ms(s) & about1(s,c1,t) & about1(s,c2,t) & ~(c1=c2))). %Inconsistent.
fof(test_intentional_content_df2, axiom, (intCont(c,t) & about1(s1,c,t) & about1(s2,c,t) & ~(s1 = s2))). %Consistent.
fof(test_bel_ms, axiom, (belState(s6) & desState(d1) & intState(i3) & about2(s6,z6,t8))). %Consistent.
fof(test_bel_ms_need, axiom, (needState(s7) & about2(s7,z6,t8))). %Consistent.
%fof(test_end_goals_instances, axiom, (egoal(a1,y1,t1) & igoal(a1,y1,t1))). %Inconsistent.
fof(ax_need1_not_need0, axiom, ((need1(a12,b12,t12) & ~need0(a12,b12,t12)))). %Consistent. So not every need1 is associated to a need0 (i.e. to a need state).
fof(ax_need2_not_need0, axiom, ((need2(a12,b12,t12) & ~need0(a12,b12,t12)))). %Consistent. So not every need2 is associated to a need0 (i.e. to a need state).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%THEOREMS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Unicity of the agent of a mental state:

fof(th_unicity_of_agent_ms, conjecture, (![X,A,B,S,R,T1,T2]: ((ms(X) & apo(A) & apo(B) & pc(A,X,T1) & pc(B,X,T2))
                 => (A=B)))).

%Intentional objects at t are classified by a content and are present at t:

fof(th_existence_of_content1, conjecture, (![X,Z,T]:(about2(X,Z,T) => (?[Y]: (con(Y) & about1(X,Y,T) & cf(Y,Z,T) & presentAt(Z,T)))))).

%Intentional content must be about something:

fof(th_intentional_content_about, conjecture, ((intCont(c,t) => ?[X]: (about1(X,c,t))))).

%Unicity of the content of a mental state:

fof(th_unicity_of_agent_ms, conjecture, ((![X,Y,Y1,T,T1]:(about1(X,Y,T) & about1(X,Y1,T1)) => Y = Y1))).

%Two incompatible desires at t do not provide a goal at t:

fof(th_goals_incomp_des, conjecture, ((des(a9,c11,t) & des(a9,c12,t) & ~?[E]: (cf(c11,E,t) & cf(c12,E,t))) => ~goal(a9,c11,t))).

%A unique desire at t is a goal at t:

fof(th_goals_unicity_des, conjecture, ((des(a9,c11,t) & ~?[Y]: (des(a9,Y,t))) => goal(a9,c11,t))). %ok. a unique desire at t is a goal at t.

%Goals require a need or a desire state:

fof(th_igoals_need_des, conjecture, (![A,Y,T]: (igoal(A,Y,T) => ?[X]: ((needState(X) | desState(X)) & (about1(X,Y,T)))))). %ok
fof(th_egoals_need_des, conjecture, (![A,Y,T]: (egoal(A,Y,T) => ?[X]: ((needState(X) | desState(X)) & (about1(X,Y,T)))))). %ok

%Need2 implies need1:

fof(th_needs2_needs1, conjecture, (![A,Y,T]: (need2(A,Y,T) => need1(A,Y,T)))). %ok.

%If a need has a satisfier, then the need is about that satisfier:

fof(th_needs_and_satisfiers, conjecture, (![A,Y,T]: (?[E]: ((need2(A,Y,T) & sat(E,Y,T)))) => about2(Y,E,T))). %ok.

%Need3 implies need0:

fof(th_need3_need0, conjecture, (![A,Y,T]: (need3(A,Y,T) => (need0(A,Y,T))))).

fof(th_need3_igoals, conjecture, (![A,Y,T]: (need3(A,Y,T) => (~igoal(A,Y,T))))).
