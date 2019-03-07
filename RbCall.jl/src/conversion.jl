convert(::Type{VALUE}, ::Nothing) = RUBY_Qnil

convert(::Type{VALUE}, b::Bool) = b ? RUBY_Qtrue : RUBY_Qfalse

convert(::Type{VALUE}, i::Int8) = RB_INT2FIX(Cint(i))
convert(::Type{VALUE}, i::UInt8) = RB_INT2FIX(Cint(i))
convert(::Type{VALUE}, i::Int16) = RB_INT2FIX(Cint(i))
convert(::Type{VALUE}, i::UInt16) = RB_INT2FIX(Cint(i))
convert(::Type{VALUE}, i::Int32) = RB_LONG2NUM(Clong(i))
convert(::Type{VALUE}, i::UInt32) = RB_ULONG2NUM(Culong(i))

if sizeof(Clong) == sizeof(Int64)
  convert(::Type{VALUE}, i::Int64) = RB_LONG2NUM(Clong(i))
  convert(::Type{VALUE}, i::UInt64) = RB_ULONG2NUM(Culong(i))
else
  convert(::Type{VALUE}, i::Int64) = RB_LL2NUM(Clonglong(i))
  convert(::Type{VALUE}, i::UInt64) = RB_ULL2NUM(Culonglong(i))
end

if sizeof(Clonglong) == sizeof(Int128)
  convert(::Type{VALUE}, i::Int128) = RB_LL2NUM(Clonglong(i))
  convert(::Type{VALUE}, i::UInt128) = RB_ULL2NUM(Culonglong(i))
end

function convert(::Type{VALUE}, i::Integer)
  # TODO convert to Bignum
  return RUBY_Qnil
end

convert(::Type{VALUE}, d::Union{Float64,Float32}) = DBL2NUM(Cdouble(d))

function convert(::Type{VALUE}, s::AbstractString)
  sb = String(s)
  return ccall(:rb_utf8_str_new, VALUE, (Cstring, Clong), sb, sizeof(sb))
end

# TODO
convert(::Type{VALUE}, ::Any) = RUBY_Qnil

function convert_to_ruby(value::Any)
  rbobj = convert(VALUE, value)
  return rbobj
end