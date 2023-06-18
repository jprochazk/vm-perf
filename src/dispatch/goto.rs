#[doc(hidden)]
#[macro_export]
macro_rules! __generate_goto_dispatch_loop {
  () => {};
}

pub use crate::__generate_goto_dispatch_loop as generate;
