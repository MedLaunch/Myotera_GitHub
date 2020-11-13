
##Joint angles pseudocode

##Take accelerations for 2 frames of time
#a1 = ?
#a2 = ?

##Integrate accel to convert to velocity
#g1 = integral a1
#g2 = integral a2

##Input time increment
#delta_t = ?

##Calculate time derivative angular rates

#g1_prime_num = g1(t-2*delta_t) - 8*g1(t-delta_t) + 8*g1(t+delta_t) - g1(t+2*delta_t)
#g1_prime_denom = 12*delta_t
#g1 = g1_prime_num / g1_prime_denom

#g2_prime_num = g2(t-2*delta_t) - 8*g2(t-delta_t) + 8*g2(t+delta_t) - g2(t+2*delta_t)
#g2_prime_denom = 12*delta_t
#g2 = g2_prime_num / g2_prime_denom

##Set stuff

##Calculate unit-length direction vectors
#j1 = (cos(phi_1)*cos(theta_1),cos(phi_1)*sin(theta_1),sin(phi_1))^transpose
#j2 = (cos(phi_2)*cos(theta_2),cos(phi_2)*sin(theta_2),sin(phi_2))^transpose