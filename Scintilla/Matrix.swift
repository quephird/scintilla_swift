//
// Created by Danielle Kefford on 11/21/21.
//

import Foundation

let IDENTITY4 = Matrix4(
    1, 0, 0, 0,
    0, 1, 0, 0,
    0, 0, 1, 0,
    0, 0, 0, 1
)


struct Matrix2 {
    var data: (
        Double, Double,
        Double, Double
        )

    init(
        _ x0: Double, _ y0: Double,
        _ x1: Double, _ y1: Double) {
        self.data = (x0, y0, x1, y1)
    }

    subscript(_ i: Int, _ j: Int) -> Double {
        get {
            let index = j*2+i
            switch index {
            case 0: return self.data.0
            case 1: return self.data.1
            case 2: return self.data.2
            case 3: return self.data.3
            default: fatalError()
            }
        }
        set(newValue) {
            let index = j*2+i
            switch index {
            case 0: self.data.0 = newValue
            case 1: self.data.1 = newValue
            case 2: self.data.2 = newValue
            case 3: self.data.3 = newValue
            default: fatalError()
            }
        }
    }

    func determinant() -> Double {
        self[0, 0]*self[1, 1] - self[0, 1]*self[1, 0]
    }

    func isAlmostEqual(_ other: Matrix2) -> Bool {
        for j in 0...1 {
            for i in 0...1 {
                if !self[i, j].isAlmostEqual(other[i, j]) {
                    return false
                }
            }
        }
        return true
    }
}

struct Matrix3 {
    var rows: [Tuple3]

    init(
        _ x0: Double, _ y0: Double, _ z0: Double,
        _ x1: Double, _ y1: Double, _ z1: Double,
        _ x2: Double, _ y2: Double, _ z2: Double) {
        self.rows = [
            Tuple3(x0, y0, z0),
            Tuple3(x1, y1, z1),
            Tuple3(x2, y2, z2),
        ]
    }

    func submatrix(_ row: Int, _ column: Int) -> Matrix2 {
        var m = Matrix2(
            0, 0,
            0, 0
        )
        var targetRow = 0
        for sourceRow in 0...2 {
            if sourceRow == row {
                continue
            }
            var targetColumn = 0
            for sourceColumn in 0...2 {
                if sourceColumn == column {
                    continue
                }
                m[targetColumn, targetRow] = self.rows[sourceRow].xyz[sourceColumn]
                targetColumn += 1
            }
            targetRow += 1
        }

        return m
    }

    func minor(_ row: Int, _ column: Int) -> Double {
        self.submatrix(row, column).determinant()
    }

    func cofactor(_ row: Int, _ column: Int) -> Double {
        var coefficient = 1.0
        if (row + column)%2 != 0 {
            coefficient = -1.0
        }
        let minor = self.minor(row, column)
        return coefficient*minor
    }

    func determinant() -> Double {
        var d = 0.0
        for i in 0...2 {
            d += self.cofactor(0, i)*self.rows[0].xyz[i]
        }
        return d
    }

    func isAlmostEqual(_ other: Matrix3) -> Bool {
        self.rows[0].isAlmostEqual(other.rows[0]) &&
            self.rows[1].isAlmostEqual(other.rows[1]) &&
            self.rows[2].isAlmostEqual(other.rows[2])
    }
}

struct Matrix4 {
    var rows: [Tuple4]

    init(
        _ x0: Double, _ y0: Double, _ z0: Double, _ w0: Double,
        _ x1: Double, _ y1: Double, _ z1: Double, _ w1: Double,
        _ x2: Double, _ y2: Double, _ z2: Double, _ w2: Double,
        _ x3: Double, _ y3: Double, _ z3: Double, _ w3: Double) {
        self.rows = [
            Tuple4(x0, y0, z0, w0),
            Tuple4(x1, y1, z1, w1),
            Tuple4(x2, y2, z2, w2),
            Tuple4(x3, y3, z3, w3)
        ]
    }

    func isAlmostEqual(_ other: Matrix4) -> Bool {
        self.rows[0].isAlmostEqual(other.rows[0]) &&
            self.rows[1].isAlmostEqual(other.rows[1]) &&
            self.rows[2].isAlmostEqual(other.rows[2]) &&
            self.rows[3].isAlmostEqual(other.rows[3])
    }

    func multiplyMatrix(_ other: Matrix4) -> Matrix4 {
        var m = Matrix4(
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0
        )
        for r in 0...3 {
            for c in 0...3 {
                let selfRow = self.rows[r]
                let otherColumn = Tuple4(
                    other.rows[0].xyzw[c],
                    other.rows[1].xyzw[c],
                    other.rows[2].xyzw[c],
                    other.rows[3].xyzw[c]
                )
                m.rows[r].xyzw[c] = selfRow.dot(otherColumn)
            }
        }
        return m
    }

    func multiplyTuple(_ tuple: Tuple4) -> Tuple4 {
        var t = Tuple4(0, 0, 0, 0)
        for r in 0...3 {
            let selfRow = self.rows[r]
            t.xyzw[r] = selfRow.dot(tuple)
        }
        return t
    }

    func transpose() -> Matrix4 {
        var m = Matrix4(
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0
        )
        for r in 0...3 {
            for c in 0...3 {
                m.rows[r].xyzw[c] = self.rows[c].xyzw[r]
            }
        }
        return m
    }

    func submatrix(_ row: Int, _ column: Int) -> Matrix3 {
        var m = Matrix3(
            0, 0, 0,
            0, 0, 0,
            0, 0, 0
        )
        var targetRow = 0
        for sourceRow in 0...3 {
            if sourceRow == row {
                continue
            }
            var targetColumn = 0
            for sourceColumn in 0...3 {
                if sourceColumn == column {
                    continue
                }
                m.rows[targetRow].xyz[targetColumn] = self.rows[sourceRow].xyzw[sourceColumn]
                targetColumn += 1
            }
            targetRow += 1
        }

        return m
    }

    func minor(_ row: Int, _ column: Int) -> Double {
        self.submatrix(row, column).determinant()
    }

    func cofactor(_ row: Int, _ column: Int) -> Double {
        var coefficient = 1.0
        if (row + column)%2 != 0 {
            coefficient = -1.0
        }
        let minor = self.minor(row, column)
        return coefficient*minor
    }

    func determinant() -> Double {
        var d = 0.0
        for i in 0...3 {
            d += self.cofactor(0, i)*self.rows[0].xyzw[i]
        }
        return d
    }

    func inverse() -> Matrix4 {
        let d = self.determinant()
        var m = Matrix4(
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0
        )
        for r in 0...3 {
            for c in 0...3 {
                m.rows[c].xyzw[r] = self.cofactor(r, c)/d
            }
        }
        return m
    }
}
