/* Basic type definitions
 * =============================== */
typedef string rpc_string<255>;
typedef opaque rpc_hash<20>;
typedef opaque blob<>;
/* ====================== */

/* Manager RPC types and functions
 * =============================== */
enum event_type {
	EVENT_ADD = 0,
	EVENT_DEL = 1
};

struct rpc_mytimeval {
	unsigned mtv_sec;
	unsigned mtv_usec;
};

struct rpc_node {
	rpc_string ip;
	unsigned port;
	rpc_hash id;
};

struct rpc_node_list {
	unsigned ver;
	rpc_node nodes<>;
};

struct rpc_memb_change {
	event_type event;
	rpc_node node;
	unsigned ver;
};

struct rpc_memb_delta {
	rpc_memb_change changes<>;
};

program RPC_MANAGER {
	version	RPC_MANAGER_VERSION {
		void REGISTER(rpc_node) = 0;
		rpc_node_list GET_NODE_LIST(void) = 1;
		unsigned GET_NODE_LIST_VERSION(void) = 2;
		rpc_memb_delta GET_NODE_LIST_DELTA(unsigned) = 3;
		void REPORT_BAD(rpc_node) = 4;
	} = 1;
} = 31313;
/* ====================== */

/* Chain Node RPC types and functions
 * =============================== */
 
struct head_write_arg {
 	rpc_hash chain;
 	rpc_hash id;
	blob data;
};
 
struct propagate_arg {
 	rpc_hash chain;
 	rpc_hash id;
 	rpc_mytimeval ver;
 	blob data;
 	bool committed;
};
 
struct ack_arg {
 	rpc_hash chain;
 	rpc_hash id;
 	rpc_mytimeval ver;
};
 
struct query_obj_ver_arg {
 	rpc_hash chain;
 	rpc_hash id;
};
 
struct query_obj_ver_ret {
 	rpc_mytimeval hist;
 	rpc_mytimeval pend;
};
 
struct tail_read_arg {
 	rpc_hash chain;
 	rpc_hash id;
};
 
struct tail_read_ex_arg {
 	rpc_hash chain;
 	rpc_hash id;
 	bool dirty;
};
 
struct tail_read_ex_ret {
 	blob data;
 	bool dirty;
 	rpc_mytimeval ver;
};
 
enum add_chain_ret {
	ADD_CHAIN_SUCCESS = 0,
	ADD_CHAIN_FAILURE = 1,
	ADD_CHAIN_EXISTS = 2
};
 
struct add_chain_arg {
 	rpc_hash id;
 	rpc_string data_centers<>;
 	unsigned chain_size;
};

struct test_and_set_arg {
	rpc_hash chain;
	rpc_hash id;
	blob data;
	rpc_mytimeval ver;
};
 
program CHAIN_NODE {
	version CHAIN_NODE_VERSION {
 		/*External functions*/
 		blob TAIL_READ(rpc_hash) = 0;   /* TODO: tail_read_arg */
 		bool HEAD_WRITE(head_write_arg) = 1;
  		tail_read_ex_ret TAIL_READ_EX(tail_read_ex_arg) = 8;
  		add_chain_ret ADD_CHAIN(add_chain_arg) = 9;
  		bool TEST_AND_SET(test_and_set_arg) = 10;
 		
 		/*Internal functions*/
 		bool PROPAGATE(propagate_arg) = 2;
 		query_obj_ver_ret QUERY_OBJ_VER(rpc_hash) = 3;  /* TODO: query_obj_ver_arg */
 		bool ACK(ack_arg) = 4;
 		bool BACK_PROPAGATE(propagate_arg) = 6;
 		bool NO_OP(void) = 7;
	} = 1;
} = 21212;
/* ====================== */
