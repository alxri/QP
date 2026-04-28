; ModuleID = '/home/romoirib/QP/spmv_csc_tmp/spmv_csc/spmv_csc/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%"class.hls::vector<int, 16>" = type { %"struct.std::array<int, 16>" }
%"struct.std::array<int, 16>" = type { [16 x i32] }
%"class.hls::vector<float, 16>" = type { %"struct.std::array<float, 16>" }
%"struct.std::array<float, 16>" = type { [16 x float] }

; Function Attrs: noinline
define void @apatb_spmv_csc_ir(i32 %num_rows, i32 %num_cols, i32 %nnz, %"class.hls::vector<int, 16>"* noalias nocapture nonnull readonly align 64 "maxi" %A_row_idx, i32* noalias nocapture nonnull readonly "maxi" %A_col_ptr, %"class.hls::vector<float, 16>"* noalias nocapture nonnull readonly align 64 "maxi" %A_values, float* noalias nocapture nonnull readonly "maxi" %x, %"class.hls::vector<float, 16>"* noalias nocapture nonnull align 64 "maxi" %y) local_unnamed_addr #0 {
entry:
  %0 = bitcast %"class.hls::vector<int, 16>"* %A_row_idx to [12500 x %"class.hls::vector<int, 16>"]*
  %1 = call i8* @malloc(i64 800000)
  %A_row_idx_copy = bitcast i8* %1 to [12500 x i512]*
  %2 = bitcast i32* %A_col_ptr to [1025 x i32]*
  %3 = call i8* @malloc(i64 4100)
  %A_col_ptr_copy = bitcast i8* %3 to [1025 x i32]*
  %4 = bitcast %"class.hls::vector<float, 16>"* %A_values to [12500 x %"class.hls::vector<float, 16>"]*
  %5 = call i8* @malloc(i64 800000)
  %A_values_copy = bitcast i8* %5 to [12500 x i512]*
  %6 = bitcast float* %x to [1024 x float]*
  %7 = call i8* @malloc(i64 4096)
  %x_copy = bitcast i8* %7 to [1024 x float]*
  %8 = bitcast %"class.hls::vector<float, 16>"* %y to [64 x %"class.hls::vector<float, 16>"]*
  %9 = call i8* @malloc(i64 4096)
  %y_copy = bitcast i8* %9 to [64 x i512]*
  call fastcc void @copy_in([12500 x %"class.hls::vector<int, 16>"]* nonnull align 64 %0, [12500 x i512]* %A_row_idx_copy, [1025 x i32]* nonnull %2, [1025 x i32]* %A_col_ptr_copy, [12500 x %"class.hls::vector<float, 16>"]* nonnull align 64 %4, [12500 x i512]* %A_values_copy, [1024 x float]* nonnull %6, [1024 x float]* %x_copy, [64 x %"class.hls::vector<float, 16>"]* nonnull align 64 %8, [64 x i512]* %y_copy)
  call void @apatb_spmv_csc_hw(i32 %num_rows, i32 %num_cols, i32 %nnz, [12500 x i512]* %A_row_idx_copy, [1025 x i32]* %A_col_ptr_copy, [12500 x i512]* %A_values_copy, [1024 x float]* %x_copy, [64 x i512]* %y_copy)
  call void @copy_back([12500 x %"class.hls::vector<int, 16>"]* %0, [12500 x i512]* %A_row_idx_copy, [1025 x i32]* %2, [1025 x i32]* %A_col_ptr_copy, [12500 x %"class.hls::vector<float, 16>"]* %4, [12500 x i512]* %A_values_copy, [1024 x float]* %6, [1024 x float]* %x_copy, [64 x %"class.hls::vector<float, 16>"]* %8, [64 x i512]* %y_copy)
  call void @free(i8* %1)
  tail call void @free(i8* %3)
  call void @free(i8* %5)
  tail call void @free(i8* %7)
  call void @free(i8* %9)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in([12500 x %"class.hls::vector<int, 16>"]* readonly align 64, [12500 x i512]*, [1025 x i32]* readonly, [1025 x i32]*, [12500 x %"class.hls::vector<float, 16>"]* readonly align 64, [12500 x i512]*, [1024 x float]* readonly, [1024 x float]*, [64 x %"class.hls::vector<float, 16>"]* readonly align 64, [64 x i512]*) unnamed_addr #1 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a12500class.hls::vector<int, 16>"([12500 x i512]* %1, [12500 x %"class.hls::vector<int, 16>"]* align 64 %0)
  call fastcc void @onebyonecpy_hls.p0a1025i32([1025 x i32]* %3, [1025 x i32]* %2)
  call fastcc void @"onebyonecpy_hls.p0a12500class.hls::vector<float, 16>.100"([12500 x i512]* %5, [12500 x %"class.hls::vector<float, 16>"]* align 64 %4)
  call fastcc void @onebyonecpy_hls.p0a1024f32([1024 x float]* %7, [1024 x float]* %6)
  call fastcc void @"onebyonecpy_hls.p0a64class.hls::vector<float, 16>"([64 x i512]* %9, [64 x %"class.hls::vector<float, 16>"]* align 64 %8)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a12500class.hls::vector<int, 16>"([12500 x i512]* %dst, [12500 x %"class.hls::vector<int, 16>"]* readonly align 64 %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [12500 x i512]* %dst, null
  %1 = icmp eq [12500 x %"class.hls::vector<int, 16>"]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a12500class.hls::vector<int, 16>"([12500 x i512]* nonnull %dst, [12500 x %"class.hls::vector<int, 16>"]* nonnull %src, i64 12500)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a12500class.hls::vector<int, 16>"([12500 x i512]* %dst, [12500 x %"class.hls::vector<int, 16>"]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [12500 x %"class.hls::vector<int, 16>"]* %src, null
  %1 = icmp eq [12500 x i512]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond5 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond5, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx6 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.03 = getelementptr [12500 x %"class.hls::vector<int, 16>"], [12500 x %"class.hls::vector<int, 16>"]* %src, i64 0, i64 %for.loop.idx6, i32 0, i32 0
  %3 = getelementptr [12500 x i512], [12500 x i512]* %dst, i64 0, i64 %for.loop.idx6
  call void @arraycpy_hls.p0a16i32(i512* %3, i64 0, [16 x i32]* %src.addr.0.03, i64 16)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx6, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a16i32(i512* %dst, i64 %dst_idx, [16 x i32]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [16 x i32]* %src, null
  %1 = icmp eq i512* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = mul i64 32, %for.loop.idx2
  %4 = add i64 %dst_idx, %3
  %src.addr = getelementptr [16 x i32], [16 x i32]* %src, i64 0, i64 %for.loop.idx2
  %5 = load i32, i32* %src.addr, align 4
  %6 = load i512, i512* %dst, align 4
  %7 = zext i64 %4 to i512
  %8 = shl i512 4294967295, %7
  %9 = zext i32 %5 to i512
  %10 = shl i512 %9, %7
  %thr.xor1 = xor i512 %8, -1
  %thr.and2 = and i512 %6, %thr.xor1
  %thr.or3 = or i512 %thr.and2, %10
  store i512 %thr.or3, i512* %dst, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a1025i32([1025 x i32]* %dst, [1025 x i32]* readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [1025 x i32]* %dst, null
  %1 = icmp eq [1025 x i32]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a1025i32([1025 x i32]* nonnull %dst, [1025 x i32]* nonnull %src, i64 1025)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a1025i32([1025 x i32]* %dst, [1025 x i32]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [1025 x i32]* %src, null
  %1 = icmp eq [1025 x i32]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [1025 x i32], [1025 x i32]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [1025 x i32], [1025 x i32]* %src, i64 0, i64 %for.loop.idx2
  %3 = load i32, i32* %src.addr, align 4
  store i32 %3, i32* %dst.addr, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a12500class.hls::vector<float, 16>"([12500 x %"class.hls::vector<float, 16>"]* align 64 %dst, [12500 x i512]* readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [12500 x %"class.hls::vector<float, 16>"]* %dst, null
  %1 = icmp eq [12500 x i512]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a12500class.hls::vector<float, 16>"([12500 x %"class.hls::vector<float, 16>"]* nonnull %dst, [12500 x i512]* nonnull %src, i64 12500)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a12500class.hls::vector<float, 16>"([12500 x %"class.hls::vector<float, 16>"]* %dst, [12500 x i512]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [12500 x i512]* %src, null
  %1 = icmp eq [12500 x %"class.hls::vector<float, 16>"]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond5 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond5, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx6 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [12500 x i512], [12500 x i512]* %src, i64 0, i64 %for.loop.idx6
  %dst.addr.0.04 = getelementptr [12500 x %"class.hls::vector<float, 16>"], [12500 x %"class.hls::vector<float, 16>"]* %dst, i64 0, i64 %for.loop.idx6, i32 0, i32 0
  call void @arraycpy_hls.p0a16f32.112([16 x float]* %dst.addr.0.04, i512* %3, i64 0, i64 16)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx6, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a1024f32([1024 x float]* %dst, [1024 x float]* readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [1024 x float]* %dst, null
  %1 = icmp eq [1024 x float]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a1024f32([1024 x float]* nonnull %dst, [1024 x float]* nonnull %src, i64 1024)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a1024f32([1024 x float]* %dst, [1024 x float]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [1024 x float]* %src, null
  %1 = icmp eq [1024 x float]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [1024 x float], [1024 x float]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [1024 x float], [1024 x float]* %src, i64 0, i64 %for.loop.idx2
  %3 = load float, float* %src.addr, align 4
  store float %3, float* %dst.addr, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a64class.hls::vector<float, 16>"([64 x i512]* %dst, [64 x %"class.hls::vector<float, 16>"]* readonly align 64 %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [64 x i512]* %dst, null
  %1 = icmp eq [64 x %"class.hls::vector<float, 16>"]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a64class.hls::vector<float, 16>"([64 x i512]* nonnull %dst, [64 x %"class.hls::vector<float, 16>"]* nonnull %src, i64 64)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a64class.hls::vector<float, 16>"([64 x i512]* %dst, [64 x %"class.hls::vector<float, 16>"]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [64 x %"class.hls::vector<float, 16>"]* %src, null
  %1 = icmp eq [64 x i512]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond5 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond5, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx6 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.03 = getelementptr [64 x %"class.hls::vector<float, 16>"], [64 x %"class.hls::vector<float, 16>"]* %src, i64 0, i64 %for.loop.idx6, i32 0, i32 0
  %3 = getelementptr [64 x i512], [64 x i512]* %dst, i64 0, i64 %for.loop.idx6
  call void @arraycpy_hls.p0a16f32(i512* %3, i64 0, [16 x float]* %src.addr.0.03, i64 16)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx6, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_out([12500 x %"class.hls::vector<int, 16>"]* align 64, [12500 x i512]* readonly, [1025 x i32]*, [1025 x i32]* readonly, [12500 x %"class.hls::vector<float, 16>"]* align 64, [12500 x i512]* readonly, [1024 x float]*, [1024 x float]* readonly, [64 x %"class.hls::vector<float, 16>"]* align 64, [64 x i512]* readonly) unnamed_addr #4 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a12500class.hls::vector<int, 16>.86"([12500 x %"class.hls::vector<int, 16>"]* align 64 %0, [12500 x i512]* %1)
  call fastcc void @onebyonecpy_hls.p0a1025i32([1025 x i32]* %2, [1025 x i32]* %3)
  call fastcc void @"onebyonecpy_hls.p0a12500class.hls::vector<float, 16>"([12500 x %"class.hls::vector<float, 16>"]* align 64 %4, [12500 x i512]* %5)
  call fastcc void @onebyonecpy_hls.p0a1024f32([1024 x float]* %6, [1024 x float]* %7)
  call fastcc void @"onebyonecpy_hls.p0a64class.hls::vector<float, 16>.121"([64 x %"class.hls::vector<float, 16>"]* align 64 %8, [64 x i512]* %9)
  ret void
}

declare i8* @malloc(i64) local_unnamed_addr

declare void @free(i8*) local_unnamed_addr

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a12500class.hls::vector<int, 16>.86"([12500 x %"class.hls::vector<int, 16>"]* align 64 %dst, [12500 x i512]* readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [12500 x %"class.hls::vector<int, 16>"]* %dst, null
  %1 = icmp eq [12500 x i512]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a12500class.hls::vector<int, 16>.89"([12500 x %"class.hls::vector<int, 16>"]* nonnull %dst, [12500 x i512]* nonnull %src, i64 12500)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a12500class.hls::vector<int, 16>.89"([12500 x %"class.hls::vector<int, 16>"]* %dst, [12500 x i512]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [12500 x i512]* %src, null
  %1 = icmp eq [12500 x %"class.hls::vector<int, 16>"]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond5 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond5, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx6 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [12500 x i512], [12500 x i512]* %src, i64 0, i64 %for.loop.idx6
  %dst.addr.0.04 = getelementptr [12500 x %"class.hls::vector<int, 16>"], [12500 x %"class.hls::vector<int, 16>"]* %dst, i64 0, i64 %for.loop.idx6, i32 0, i32 0
  call void @arraycpy_hls.p0a16i32.92([16 x i32]* %dst.addr.0.04, i512* %3, i64 0, i64 16)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx6, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a16i32.92([16 x i32]* %dst, i512* readonly %src, i64 %src_idx, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq i512* %src, null
  %1 = icmp eq [16 x i32]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [16 x i32], [16 x i32]* %dst, i64 0, i64 %for.loop.idx2
  %3 = mul i64 32, %for.loop.idx2
  %4 = add i64 %src_idx, %3
  %5 = load i512, i512* %src, align 4
  %6 = zext i64 %4 to i512
  %7 = lshr i512 %5, %6
  %.partselect = trunc i512 %7 to i32
  store i32 %.partselect, i32* %dst.addr, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a12500class.hls::vector<float, 16>.100"([12500 x i512]* %dst, [12500 x %"class.hls::vector<float, 16>"]* readonly align 64 %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [12500 x i512]* %dst, null
  %1 = icmp eq [12500 x %"class.hls::vector<float, 16>"]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a12500class.hls::vector<float, 16>.103"([12500 x i512]* nonnull %dst, [12500 x %"class.hls::vector<float, 16>"]* nonnull %src, i64 12500)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a12500class.hls::vector<float, 16>.103"([12500 x i512]* %dst, [12500 x %"class.hls::vector<float, 16>"]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [12500 x %"class.hls::vector<float, 16>"]* %src, null
  %1 = icmp eq [12500 x i512]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond5 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond5, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx6 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.03 = getelementptr [12500 x %"class.hls::vector<float, 16>"], [12500 x %"class.hls::vector<float, 16>"]* %src, i64 0, i64 %for.loop.idx6, i32 0, i32 0
  %3 = getelementptr [12500 x i512], [12500 x i512]* %dst, i64 0, i64 %for.loop.idx6
  call void @arraycpy_hls.p0a16f32(i512* %3, i64 0, [16 x float]* %src.addr.0.03, i64 16)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx6, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a16f32(i512* %dst, i64 %dst_idx, [16 x float]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [16 x float]* %src, null
  %1 = icmp eq i512* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = mul i64 32, %for.loop.idx2
  %4 = add i64 %dst_idx, %3
  %src.addr = getelementptr [16 x float], [16 x float]* %src, i64 0, i64 %for.loop.idx2
  %5 = load float, float* %src.addr, align 4
  %6 = call i32 @_llvm.fpga.pack.none.i32.f32(float %5)
  %7 = load i512, i512* %dst, align 4
  %8 = zext i64 %4 to i512
  %9 = shl i512 4294967295, %8
  %10 = zext i32 %6 to i512
  %11 = shl i512 %10, %8
  %thr.xor1 = xor i512 %9, -1
  %thr.and2 = and i512 %7, %thr.xor1
  %thr.or3 = or i512 %thr.and2, %11
  store i512 %thr.or3, i512* %dst, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: alwaysinline nounwind readnone willreturn
define internal i32 @_llvm.fpga.pack.none.i32.f32(float %A) #5 {
  %A.cast = bitcast float %A to i32
  ret i32 %A.cast
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a16f32.112([16 x float]* %dst, i512* readonly %src, i64 %src_idx, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq i512* %src, null
  %1 = icmp eq [16 x float]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [16 x float], [16 x float]* %dst, i64 0, i64 %for.loop.idx2
  %3 = mul i64 32, %for.loop.idx2
  %4 = add i64 %src_idx, %3
  %5 = load i512, i512* %src, align 4
  %6 = zext i64 %4 to i512
  %7 = lshr i512 %5, %6
  %.partselect = trunc i512 %7 to i32
  %8 = call float @_llvm.fpga.unpack.none.f32.i32(i32 %.partselect)
  store float %8, float* %dst.addr, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: alwaysinline nounwind readnone willreturn
define internal float @_llvm.fpga.unpack.none.f32.i32(i32 %A) #5 {
  %A.cast = bitcast i32 %A to float
  ret float %A.cast
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a64class.hls::vector<float, 16>.121"([64 x %"class.hls::vector<float, 16>"]* align 64 %dst, [64 x i512]* readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [64 x %"class.hls::vector<float, 16>"]* %dst, null
  %1 = icmp eq [64 x i512]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a64class.hls::vector<float, 16>.124"([64 x %"class.hls::vector<float, 16>"]* nonnull %dst, [64 x i512]* nonnull %src, i64 64)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a64class.hls::vector<float, 16>.124"([64 x %"class.hls::vector<float, 16>"]* %dst, [64 x i512]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [64 x i512]* %src, null
  %1 = icmp eq [64 x %"class.hls::vector<float, 16>"]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond5 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond5, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx6 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [64 x i512], [64 x i512]* %src, i64 0, i64 %for.loop.idx6
  %dst.addr.0.04 = getelementptr [64 x %"class.hls::vector<float, 16>"], [64 x %"class.hls::vector<float, 16>"]* %dst, i64 0, i64 %for.loop.idx6, i32 0, i32 0
  call void @arraycpy_hls.p0a16f32.112([16 x float]* %dst.addr.0.04, i512* %3, i64 0, i64 16)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx6, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

declare void @apatb_spmv_csc_hw(i32, i32, i32, [12500 x i512]*, [1025 x i32]*, [12500 x i512]*, [1024 x float]*, [64 x i512]*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back([12500 x %"class.hls::vector<int, 16>"]* align 64, [12500 x i512]* readonly, [1025 x i32]*, [1025 x i32]* readonly, [12500 x %"class.hls::vector<float, 16>"]* align 64, [12500 x i512]* readonly, [1024 x float]*, [1024 x float]* readonly, [64 x %"class.hls::vector<float, 16>"]* align 64, [64 x i512]* readonly) unnamed_addr #4 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a64class.hls::vector<float, 16>.121"([64 x %"class.hls::vector<float, 16>"]* align 64 %8, [64 x i512]* %9)
  ret void
}

declare void @spmv_csc_hw_stub(i32, i32, i32, %"class.hls::vector<int, 16>"* noalias nocapture nonnull readonly, i32* noalias nocapture nonnull readonly, %"class.hls::vector<float, 16>"* noalias nocapture nonnull readonly, float* noalias nocapture nonnull readonly, %"class.hls::vector<float, 16>"* noalias nocapture nonnull)

define void @spmv_csc_hw_stub_wrapper(i32, i32, i32, [12500 x i512]*, [1025 x i32]*, [12500 x i512]*, [1024 x float]*, [64 x i512]*) #6 {
entry:
  %8 = call i8* @malloc(i64 800000)
  %9 = bitcast i8* %8 to [12500 x %"class.hls::vector<int, 16>"]*
  %10 = call i8* @malloc(i64 800000)
  %11 = bitcast i8* %10 to [12500 x %"class.hls::vector<float, 16>"]*
  %12 = call i8* @malloc(i64 4096)
  %13 = bitcast i8* %12 to [64 x %"class.hls::vector<float, 16>"]*
  call void @copy_out([12500 x %"class.hls::vector<int, 16>"]* %9, [12500 x i512]* %3, [1025 x i32]* null, [1025 x i32]* %4, [12500 x %"class.hls::vector<float, 16>"]* %11, [12500 x i512]* %5, [1024 x float]* null, [1024 x float]* %6, [64 x %"class.hls::vector<float, 16>"]* %13, [64 x i512]* %7)
  %14 = bitcast [12500 x %"class.hls::vector<int, 16>"]* %9 to %"class.hls::vector<int, 16>"*
  %15 = bitcast [1025 x i32]* %4 to i32*
  %16 = bitcast [12500 x %"class.hls::vector<float, 16>"]* %11 to %"class.hls::vector<float, 16>"*
  %17 = bitcast [1024 x float]* %6 to float*
  %18 = bitcast [64 x %"class.hls::vector<float, 16>"]* %13 to %"class.hls::vector<float, 16>"*
  call void @spmv_csc_hw_stub(i32 %0, i32 %1, i32 %2, %"class.hls::vector<int, 16>"* %14, i32* %15, %"class.hls::vector<float, 16>"* %16, float* %17, %"class.hls::vector<float, 16>"* %18)
  call void @copy_in([12500 x %"class.hls::vector<int, 16>"]* %9, [12500 x i512]* %3, [1025 x i32]* null, [1025 x i32]* %4, [12500 x %"class.hls::vector<float, 16>"]* %11, [12500 x i512]* %5, [1024 x float]* null, [1024 x float]* %6, [64 x %"class.hls::vector<float, 16>"]* %13, [64 x i512]* %7)
  call void @free(i8* %8)
  call void @free(i8* %10)
  call void @free(i8* %12)
  ret void
}

attributes #0 = { noinline "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { alwaysinline nounwind readnone willreturn }
attributes #6 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
