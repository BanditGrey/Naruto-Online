package Rendering.Overlayers.TongLingAnimal
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_INHERITPRACTICE;
   import Resources.Strings.STRING_TONGLING;
   import flash.utils.ByteArray;
   
   public class TongLingOtherMsgCopy extends TOverlayer
   {
      
      protected static const COLOR_Context_BLACK:uint = 4278190080;
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_AppendAttributes:uint = 4284940032;
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      public static var TongLingMsgTip:TongLingOtherMsgCopy = null;
      
      protected var TongLingArr:Array;
      
      protected var MainAttr:Array;
      
      protected var ViceAttr:Array;
      
      protected var namePainter:TPainterTextEffect;
      
      protected var nameBound:TBounds;
      
      protected var attrPainter:TPainterTextEffect;
      
      protected var attrBound:TBounds;
      
      protected var VecFivePainter:Vector.<TPainterTextEffect>;
      
      protected var VecFiveBound:Vector.<TBounds>;
      
      protected var b:int = 0;
      
      protected var ol:int = 0;
      
      protected var _cl:int = 0;
      
      public function TongLingOtherMsgCopy(param1:TUIComponent)
      {
         var _loc3_:TPainterTextEffect = null;
         var _loc4_:TBounds = null;
         super(param1);
         var _loc2_:int = 0;
         this.TongLingArr = new Array();
         this.MainAttr = new Array();
         this.ViceAttr = new Array();
         this.namePainter = ConstructPainterTextEffect(COLOR_Context_AppendAttributes);
         this.nameBound = new TBounds();
         this.VecFivePainter = new Vector.<TPainterTextEffect>();
         this.VecFiveBound = new Vector.<TBounds>();
         while(_loc2_ < 5)
         {
            _loc3_ = ConstructPainterTextEffect(COLOR_Context_AppendAttributes);
            _loc4_ = new TBounds();
            this.VecFivePainter[_loc2_] = _loc3_;
            this.VecFiveBound[_loc2_] = _loc4_;
            _loc2_++;
         }
         this.attrPainter = ConstructPainterTextEffect(COLOR_Context_AppendAttributes);
         this.attrBound = new TBounds();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      public static function getTipIntence(param1:TUIComponent) : TongLingOtherMsgCopy
      {
         if(!TongLingMsgTip)
         {
            TongLingMsgTip = new TongLingOtherMsgCopy(param1);
         }
         return TongLingMsgTip;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc4_:TBB_Status = null;
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:int = 0;
         this._cl = FContext as int;
         var _loc1_:TConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_Open) as TConfigValue;
         this.ol = _loc1_.Value as int;
         var _loc2_:int = 0;
         while(_loc2_ < 5)
         {
            this.VecFivePainter[_loc2_].visible = false;
            this.VecFiveBound[_loc2_].Y = 0;
            _loc2_++;
         }
         this.attrPainter.visible = false;
         if(this._cl < this.ol)
         {
            BoundsAlignDown(this.nameBound);
            this.namePainter.Text = STRING_TONGLING.TONGLING_open_level + this.ol + STRING_TONGLING.TONGLING_SAY + STRING_TONGLING.TONGLING_OPEN;
            this.namePainter.Evaluate(this.nameBound);
            BoundsContextUnion(this.nameBound);
            return;
         }
         BoundsAlignDown(this.nameBound);
         this.namePainter.Text = STRING_TONGLING.TONGLING_ANIMAL + "\n";
         this.namePainter.Font.Color = COLOR_Context_White;
         this.namePainter.Evaluate(this.nameBound);
         BoundsContextUnion(this.nameBound);
         var _loc3_:int = 0;
         this.b = 0;
         if(this.TongLingArr.length == 0)
         {
            this.b = 2;
            BoundsAlignDown(this.VecFiveBound[0]);
            this.VecFivePainter[0].Text = STRING_TONGLING.TONGLING_MAIN + ":  " + "(" + STRING_TONGLING.TONGLING_NULL + ")\n";
            this.VecFivePainter[0].Font.Color = COLOR_Context_White;
            this.VecFivePainter[0].Evaluate(this.VecFiveBound[0]);
            BoundsContextUnion(this.VecFiveBound[0]);
            this.VecFivePainter[0].visible = true;
            BoundsAlignDown(this.VecFiveBound[1]);
            this.VecFivePainter[1].Text = STRING_TONGLING.TONGLING_XIE + ":  " + "(" + STRING_TONGLING.TONGLING_NULL + ")\n";
            this.VecFivePainter[1].Font.Color = COLOR_Context_White;
            this.VecFivePainter[1].Evaluate(this.VecFiveBound[1]);
            BoundsContextUnion(this.VecFiveBound[1]);
            this.VecFivePainter[1].visible = true;
         }
         else
         {
            this.b = 0;
            _loc6_ = 0;
            while(_loc6_ < this.TongLingArr.length)
            {
               ++this.b;
               _loc7_ = Object(this.TongLingArr[_loc6_]);
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,_loc7_.id) as TBB_Status;
               if(_loc6_ == 0)
               {
                  if(_loc7_.pl == 1)
                  {
                     BoundsAlignDown(this.VecFiveBound[0]);
                     this.VecFivePainter[0].Text = STRING_TONGLING.TONGLING_MAIN + ":  " + _loc4_.Name + STRING_COMMON.FORMAT_Level + _loc7_.lv + "\n";
                     this.VecFivePainter[0].Font.Color = QUALITYCOLOR_INDEX[_loc4_.Rarity];
                     this.VecFivePainter[0].Evaluate(this.VecFiveBound[0]);
                     BoundsContextUnion(this.VecFiveBound[0]);
                     this.VecFivePainter[0].visible = true;
                     if(this.TongLingArr.length == 1)
                     {
                        BoundsAlignDown(this.VecFiveBound[1]);
                        this.VecFivePainter[1].Text = STRING_TONGLING.TONGLING_XIE + ":  " + "(" + STRING_TONGLING.TONGLING_NULL + ")\n";
                        this.VecFivePainter[1].Font.Color = COLOR_Context_White;
                        this.VecFivePainter[1].Evaluate(this.VecFiveBound[1]);
                        BoundsContextUnion(this.VecFiveBound[1]);
                        this.VecFivePainter[1].visible = true;
                     }
                  }
                  else
                  {
                     BoundsAlignDown(this.VecFiveBound[0]);
                     this.VecFivePainter[0].Text = STRING_TONGLING.TONGLING_MAIN + ":  " + "(" + STRING_TONGLING.TONGLING_NULL + ")\n";
                     this.VecFivePainter[0].Font.Color = COLOR_Context_White;
                     this.VecFivePainter[0].Evaluate(this.VecFiveBound[0]);
                     BoundsContextUnion(this.VecFiveBound[0]);
                     this.VecFivePainter[0].visible = true;
                     BoundsAlignDown(this.VecFiveBound[1]);
                     this.VecFivePainter[1].Text = STRING_TONGLING.TONGLING_XIE + ":  " + _loc4_.Name + STRING_COMMON.FORMAT_Level + _loc7_.lv + "\n";
                     this.VecFivePainter[1].Font.Color = QUALITYCOLOR_INDEX[_loc4_.Rarity];
                     this.VecFivePainter[1].Evaluate(this.VecFiveBound[1]);
                     BoundsContextUnion(this.VecFiveBound[1]);
                     this.VecFivePainter[1].visible = true;
                     _loc3_++;
                     ++this.b;
                  }
               }
               else
               {
                  BoundsAlignDown(this.VecFiveBound[_loc6_ + _loc3_]);
                  this.VecFivePainter[_loc6_ + _loc3_].Text = STRING_TONGLING.TONGLING_XIE + ":  " + _loc4_.Name + STRING_COMMON.FORMAT_Level + _loc7_.lv + "\n";
                  this.VecFivePainter[_loc6_ + _loc3_].Font.Color = QUALITYCOLOR_INDEX[_loc4_.Rarity];
                  this.VecFivePainter[_loc6_ + _loc3_].Evaluate(this.VecFiveBound[_loc6_ + _loc3_]);
                  BoundsContextUnion(this.VecFiveBound[_loc6_ + _loc3_]);
                  this.VecFivePainter[_loc6_ + _loc3_].visible = true;
               }
               _loc6_++;
            }
         }
         BoundsAlignDown(this.attrBound);
         if(this.MainAttr.length == 0)
         {
            _loc8_ = 0;
            while(_loc8_ < 6)
            {
               this.MainAttr[_loc8_] = 0;
               this.ViceAttr[_loc8_] = 0;
               _loc8_++;
            }
         }
         var _loc5_:String = STRING_TONGLING.TONGLING_ANIMAL_atrr + ":\n" + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[9] + "： +" + this.MainAttr[0] + " (" + "+" + this.ViceAttr[0] + ")\n" + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[10] + "： +" + this.MainAttr[1] + " (" + "+" + this.ViceAttr[1] + ")\n" + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[13] + "： +" + this.MainAttr[2] + " (" + "+" + this.ViceAttr[2] + ")\n" + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[14] + "： +" + this.MainAttr[3] + " (" + "+" + this.ViceAttr[3] + ")\n" + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[4] + "： +" + this.MainAttr[4] + " (" + "+" + this.ViceAttr[4] + ")\n" + STRING_INHERITPRACTICE.INHERIT_LIFE + "： +" + this.MainAttr[5] + " (" + "+" + this.ViceAttr[5] + ")\n";
         this.attrPainter.Text = _loc5_;
         this.attrPainter.Font.Color = COLOR_Context_White;
         this.attrPainter.Evaluate(this.attrBound);
         BoundsContextUnion(this.attrBound);
         this.attrPainter.visible = true;
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.namePainter.X = FBoundsRendering.X + this.nameBound.X;
         this.namePainter.Y = FBoundsRendering.Y + this.nameBound.Y;
         if(this._cl < this.ol)
         {
            return;
         }
         if(this.b == 0 || this.b == 1)
         {
            this.b = 2;
         }
         var _loc2_:int = 0;
         while(this.b)
         {
            this.VecFivePainter[_loc2_].X = FBoundsRendering.X + this.VecFiveBound[_loc2_].X;
            this.VecFivePainter[_loc2_].Y = FBoundsRendering.Y + this.VecFiveBound[_loc2_].Y;
            _loc2_++;
            --this.b;
         }
         this.attrPainter.X = FBoundsRendering.X + this.attrBound.X;
         this.attrPainter.Y = FBoundsRendering.Y + this.attrBound.Y;
      }
      
      override public function Show() : void
      {
         if(FContext == null)
         {
            return;
         }
         super.Show();
      }
      
      override protected function ContextModified() : Boolean
      {
         return true;
      }
      
      public function rendData(param1:ByteArray) : void
      {
         this.TongLingArr.length = 0;
         this.MainAttr.length = 0;
         this.ViceAttr.length = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = param1.readUnsignedInt();
         _loc2_ = param1.readUnsignedShort();
         while(_loc3_ < _loc2_)
         {
            this.TongLingArr.push({
               "id":param1.readUnsignedInt(),
               "pl":param1.readUnsignedInt(),
               "lv":param1.readUnsignedInt()
            });
            _loc3_++;
         }
         this.TongLingArr.sortOn("pl",Array.NUMERIC);
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            this.MainAttr.push(param1.readUnsignedInt());
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            this.ViceAttr.push(param1.readUnsignedInt());
            _loc3_++;
         }
      }
   }
}

