function [f_c,f_p_s,f_i,f_o,f_cg,f_b,f_m,f_sf,f_pf,f_rf] = CharacteristicFreq(f_s,Z_s,Z_p,Z_r,N_planet,D_roller,D_pitch,N_roller)
    %%%%%%%%%%%%%%%%%%Input arguments %%%%%%%%%%%%%%%%%%%%%
    % f_s: sun gear rotating frequency
    % Z_s: sun gear tooth
    % Z_p: planet tooth
    % Z_r: ring gear tooth
    % N_planet: planet amount
    % D_roller: diameter of planet bearing roller
    % D_pitch: diameter of bearing pitch
    % N_roller: roller amount
    %%%%%%%%%%%%%%%%%Output argments %%%%%%%%%%%%%%%%%%%%%%%
    % f_c: frequency of carrier
    % f_p_s: planet spinning frequency
    % f_i: characteristic frequency of inner race fault
    % f_o: characteristic frequency of outer race fault
    % f_cg: roller spinning frequency
    % f_b: characteristic frequency of roller fault
    % f_m: meshing frequency
    % f_sf: sun gear fault
    % f_pf: planet fault
    % f_rf: ring gear fault
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Contact_Angle =0;% contact angle of bearing rollers
    f_c=f_s*Z_s/(Z_s+Z_r);
    f_m=f_c*Z_r;
    f_p_s=Z_r/Z_p*f_c;
    f_i=N_roller/2*(1+D_roller/D_pitch*cos(Contact_Angle))*f_p_s;
    f_o=N_roller*(1-0.5*(1+D_roller/D_pitch*cos(Contact_Angle)))*f_p_s;
    f_b=0.5*D_pitch/D_roller*(1-(D_roller/D_pitch)^2*(cos(Contact_Angle))^2)*f_p_s;
    f_cg=0.5*(1+D_roller/D_pitch*cos(Contact_Angle))*f_p_s;
    f_sf=N_planet*(f_s-f_c);
    f_pf=f_m/Z_p;
    f_rf=f_m/Z_r*N_planet;
    end