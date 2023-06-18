#[doc(hidden)]
#[macro_export]
macro_rules! __generate_tail_dispatch_loop {
  () => {};
}

pub use crate::__generate_tail_dispatch_loop as generate;
