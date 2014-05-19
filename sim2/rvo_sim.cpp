/************************************************************************/
/* 
		Mex function RVO called from Matlab
*/
/************************************************************************/
#include "mex.h"
#include <iostream>
#include "RVO/RVO.h"
#include "RVO/RVOSimulator.h"
#include <vector>

#define NUM_PARAM 9

typedef struct pv 
{
	float x, y;
	float vx, vy;
	float prx, pry;
}pv;

RVO::RVOSimulator * sim;
std::vector<pv> pvList;
float param[NUM_PARAM];


/* RVO initial configuration */
void init()
{
	sim = new RVO::RVOSimulator();
	sim->setTimeStep(param[6]);
	//sim->setAgentDefaults(10, 10, 1.0, 1.0, 0.3, 2.0);
    /*sim->setAgentDefaults(param[0]*10,
                        (int)(param[1]*10),
                        param[2]*10,
                        param[3]*10,
                        param[4]*5,
                        param[5]*5);
    param[6] *= 2.5;*/
    sim->setAgentDefaults(param[0], param[1], param[2], param[3], param[4], param[5]);
}

// void mix_velocity(float &prv_x, float &prv_y, float v_x, float v_y, float w)
// {
//     prv_x = w*v_x + (1-w)*prv_x;
//     prv_y = w*v_y + (1-w)*prv_y;
// }
void mix_velocity(pv &agent, float w)
{
    agent.prx = w * agent.vx + (1-w) * agent.prx;
    agent.pry = w * agent.vy + (1-w) * agent.pry;
}

void rvo_sim()
{
    /* rvo - add agents */
    float mix_weight = param[8];
    std::vector<pv> origPVList; // original Pos and Vel 
    origPVList = pvList;
    
	for (int i = 0; i < pvList.size(); i ++)
	{
		sim->addAgent(RVO::Vector2(pvList[i].x, pvList[i].y));
		sim->setAgentVelocity(i, RVO::Vector2(pvList[i].vx, pvList[i].vy));
        //mix_velocity(pvList[i].prx, pvList[i].pry, pvList[i].vx, pvList[i].vy, 0.99);
        mix_velocity(pvList[i], mix_weight);
		sim->setAgentPrefVelocity(i, RVO::Vector2(pvList[i].prx, pvList[i].pry));
        
        //mexPrintf("%f %f %f %f\n", pvList[i].x, pvList[i].y, pvList[i].prx, pvList[i].pry);
	}
    
    /* simulate multiple times */
    int sim_times = (int)param[7];
    for (int i = 0; i < sim_times; i ++)
    {
        sim->doStep();
        
        for (int j = 0; j < pvList.size(); j ++)
        {
            RVO::Vector2 vel;
            vel = sim->getAgentVelocity(j);
            pvList[j].vx = vel.x(); 
            pvList[j].vy = vel.y();
            pvList[j].prx = origPVList[j].prx; // reset preferred velocity
            pvList[j].pry = origPVList[j].pry;
            mix_velocity(pvList[j], mix_weight);
            sim->setAgentPrefVelocity(j, RVO::Vector2(pvList[j].prx, pvList[j].pry));
        }
    }
    
//     /* result */
// 	RVO::Vector2 pos, vel, prv;
// 	pos = sim->getAgentPosition(id-1);
// 	vel = sim->getAgentVelocity(id-1);
//     prv = sim->getAgentPrefVelocity(id-1);
// 
// 	x = pos.x(); y = pos.y();
// 	vx = vel.x(); vy = vel.y();
}

/* the end */
void destroy()
{
    pvList.clear();
	delete sim;
}

/* The gateway function */
void mexFunction(int nlhs, mxArray * plhs[],
				 int nrhs, const mxArray * prhs[])
{
	/* process input from matlab */
	/* format: id, r[M][N]; 
	   id = the order of the target agent in all input agents
	   In matrix r, each row: (px, py, vx, vy, prx, pry) */

	int id;
	double * arr;
    double * pr;
	int row, col;

	id = mxGetScalar(prhs[0]);
	row = mxGetM(prhs[1]);
	col = mxGetN(prhs[1]);
	arr = mxGetPr(prhs[1]);
    pr = mxGetPr(prhs[2]);
		
    //printf("row = %d\n", row);
	for (int r = 0; r < row; r ++)
	{
		int c = 0;

		pv elem;

		elem.x = arr[r + row*(c++)];
		elem.y = arr[r + row*(c++)];
		elem.vx = arr[r + row*(c++)];
		elem.vy = arr[r + row*(c++)];
		elem.prx = arr[r + row*(c++)];
		elem.pry = arr[r + row*(c++)];

		pvList.push_back(elem);
	}
	
    for (int i = 0; i < NUM_PARAM; i ++)
    {
        param[i] = pr[i];
    }
    
    init();

	float x, y, vx, vy;
	rvo_sim(); // Change name plz!
    
    // Get the simualtion results
    RVO::Vector2 pos, vel, prv;
    double * o;
    
    plhs[0] = mxCreateDoubleMatrix(1, 4*row, mxREAL);
    o = mxGetPr(plhs[0]);
    for (int r = 0; r < row; r ++)
    {
        // access RVO for results    
        pos = sim->getAgentPosition(r);
        vel = sim->getAgentVelocity(r);
        prv = sim->getAgentPrefVelocity(r);

        x = pos.x(); y = pos.y();
        vx = vel.x(); vy = vel.y();
        
        // load output arrays
        int baseInd = r * 4;
        o[baseInd] = x;
        o[baseInd+1] = y;
        o[baseInd+2] = vx;
        o[baseInd+3] = vy;
    }

//  // Previous code
// 	plhs[0] = mxCreateDoubleMatrix(1, 4, mxREAL);
// 	double * o;
// 	o = mxGetPr(plhs[0]);
// 	o[0] = x;
// 	o[1] = y;
// 	o[2] = vx;
// 	o[3] = vy;

	destroy();
}

