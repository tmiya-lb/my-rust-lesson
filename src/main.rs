fn add(a: i32, b: i32) -> i32 {
    a + b
}

fn main() {
    println!("Hello, NixOS Rust world!");
    println!("2 + 3 = {}", add(2, 3));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_add() {
        assert_eq!(add(10, 20), 30);
    }

    #[test]
    fn test_add_fail() {
        // あえて失敗させてみる
        assert_eq!(add(2, 2), 4);
    }
}