package Rendering.Overlayers.TongLingAnimal
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.DatebaseVO.VO.TBB_AttriBute;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.SLogicsCore;
   import Logics.TongLing.TTongLingData;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TONGLING;
   
   public class TongLingAttriteTip extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_YELLOW:uint = 4294967040;
      
      protected static const COLOR_Context_BLACK:uint = 4278190080;
      
      protected static const COLOR_Context_AppendAttributes:uint = 4284940032;
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected var FTongLingName:TPainterTextEffect;
      
      protected var FTongLingScri:TPainterTextEffect;
      
      protected var FTongLingPractice:TPainterTextEffect;
      
      protected var FBoundsName:TBounds;
      
      protected var FBoundsScri:TBounds;
      
      protected var FBoundsPractice:TBounds;
      
      protected var FBoundsOffset:TBounds;
      
      protected var TPainterVec:Vector.<TPainterTextEffect>;
      
      protected var TBo:Vector.<TBounds>;
      
      protected var Vec:Vector.<Object>;
      
      protected var tempIndex:int = 0;
      
      public function TongLingAttriteTip(param1:TUIComponent)
      {
         var _loc3_:TPainterTextEffect = null;
         var _loc4_:TBounds = null;
         super(param1);
         var _loc2_:TConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_jilv) as TConfigValue;
         this.Vec = _loc2_.Value as Vector.<Object>;
         this.TPainterVec = new Vector.<TPainterTextEffect>();
         this.TBo = new Vector.<TBounds>();
         this.FTongLingName = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsName = new TBounds();
         this.FTongLingScri = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsScri = new TBounds();
         this.FTongLingPractice = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsPractice = new TBounds();
         var _loc5_:int = 0;
         while(_loc5_ < 4)
         {
            _loc3_ = ConstructPainterTextEffect(COLOR_Context_AppendAttributes);
            this.TPainterVec[_loc5_] = _loc3_;
            _loc4_ = new TBounds();
            this.TBo[_loc5_] = _loc4_;
            _loc5_++;
         }
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:Object = null;
         var _loc2_:String = null;
         var _loc3_:TBB_Status = null;
         var _loc4_:TBB_AttriBute = null;
         var _loc9_:String = null;
         var _loc10_:TTongLingData = null;
         var _loc12_:TBB_Status = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         _loc1_ = FContext as Object;
         var _loc5_:String = "";
         var _loc6_:int = 0;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,_loc1_.id) as TBB_Status;
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_AttriBute,_loc1_.id) as TBB_AttriBute;
         if(_loc1_.index == 0)
         {
            _loc2_ = _loc3_.ExtraAttr.substr(1,_loc3_.ExtraAttr.length - 2);
         }
         else if(_loc1_.index == 1)
         {
            _loc2_ = _loc4_.Lv1.substr(1,_loc4_.Lv1.length - 2);
         }
         else
         {
            _loc2_ = _loc4_.LvArr[_loc1_.level - 1].substr(1,_loc4_.LvArr[_loc1_.level - 1].length - 2);
            _loc5_ = STRING_COMMON.FORMAT_Level + _loc1_.level;
         }
         var _loc7_:Array = _loc2_.split(",");
         var _loc8_:Array = this.getStr(_loc3_.EvoTarget);
         BoundsAlignDown(this.FBoundsName);
         this.FTongLingName.Text = _loc3_.Name + _loc5_;
         this.FTongLingName.Font.Color = QUALITYCOLOR_INDEX[_loc3_.Rarity];
         this.FTongLingName.Evaluate(this.FBoundsName);
         BoundsContextUnion(this.FBoundsName);
         this.FTongLingScri.Text = "";
         BoundsAlignDown(this.FBoundsScri);
         if(_loc1_.index == 0)
         {
            _loc9_ = STRING_TONGLING.TONGLING_LEVEL + _loc3_.ExtraLevel + STRING_TONGLING.TONGLING_SAY + "，" + STRING_TONGLING.TONGLING_LOOK + "\n";
         }
         else if(_loc1_.index == 1)
         {
            _loc9_ = STRING_TONGLING.TONGLING_BEGIN + ":" + "\n";
         }
         else
         {
            _loc9_ = STRING_TONGLING.TONGLING_CURBEGIN + ":" + "\n";
         }
         _loc9_ = _loc9_ + "    " + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[9] + "： +" + _loc7_[0] + "\n" + "    " + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[10] + "： +" + _loc7_[1] + "\n" + "    " + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[13] + "： +" + _loc7_[2] + "\n" + "    " + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[14] + "： +" + _loc7_[3] + "\n" + "    " + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[4] + "： +" + _loc7_[4] + "\n" + "    " + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[28] + "： +" + _loc7_[5] + "\n\n";
         this.FTongLingScri.Text = _loc9_;
         this.FTongLingScri.Evaluate(this.FBoundsScri);
         BoundsContextUnion(this.FBoundsScri);
         _loc10_ = SLogicsCore.TongLingDatas.GetTongLingDataById64(_loc1_.Identifier0,_loc1_.Identifier1);
         _loc9_ = "";
         this.FTongLingPractice.Text = "";
         BoundsAlignDown(this.FBoundsPractice);
         if(_loc10_ != null)
         {
            _loc9_ = "\n" + STRING_TONGLING.TONGLING_70 + ":" + "\n";
            _loc9_ = _loc9_ + "    " + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[9] + "： +" + _loc10_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_NearAttack) + "\n" + "    " + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[10] + "： +" + _loc10_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_NearDefense) + "\n" + "    " + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[13] + "： +" + _loc10_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_StrategyAttack) + "\n" + "    " + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[14] + "： +" + _loc10_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_StrategyDefense) + "\n" + "    " + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[4] + "： +" + _loc10_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_Speed) + "\n" + "    " + STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[28] + "： +" + _loc10_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_MAXHP) + "\n\n";
         }
         if(_loc8_[0][0] != 0)
         {
            _loc6_ = 1;
            _loc9_ += STRING_TONGLING.TONGLING_LEVEL + _loc3_.EvoLevel + STRING_TONGLING.TONGLING_SAY + "，" + STRING_TONGLING.TONGLING_GOO + "\n";
         }
         this.FTongLingPractice.Text = _loc9_;
         this.FTongLingPractice.Evaluate(this.FBoundsPractice);
         BoundsContextUnion(this.FBoundsPractice);
         var _loc11_:int = 0;
         while(_loc11_ < this.TPainterVec.length)
         {
            this.TPainterVec[_loc11_].visible = false;
            _loc11_++;
         }
         this.tempIndex = 0;
         if(_loc6_)
         {
            _loc13_ = 0;
            while(_loc13_ < _loc8_.length)
            {
               if(_loc8_[_loc13_][1] == 0)
               {
                  return;
               }
               _loc12_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,_loc8_[_loc13_][1]) as TBB_Status;
               _loc14_ = int(_loc8_[_loc13_][2]);
               BoundsAlignDown(this.TBo[_loc13_]);
               this.TPainterVec[_loc13_].Text = _loc12_.Name + "    " + this.Vec[_loc14_][2] + "\n";
               this.TPainterVec[_loc13_].Font.Color = QUALITYCOLOR_INDEX[_loc12_.Rarity];
               this.TPainterVec[_loc13_].Evaluate(this.TBo[_loc13_]);
               BoundsContextUnion(this.TBo[_loc13_]);
               this.TPainterVec[_loc13_].visible = true;
               ++this.tempIndex;
               _loc13_++;
            }
         }
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FTongLingName.X = FBoundsRendering.X + this.FBoundsName.X;
         this.FTongLingName.Y = FBoundsRendering.Y + this.FBoundsName.Y;
         this.FTongLingScri.X = FBoundsRendering.X + this.FBoundsScri.X;
         this.FTongLingScri.Y = FBoundsRendering.Y + this.FBoundsScri.Y;
         this.FTongLingPractice.X = FBoundsRendering.X + this.FBoundsPractice.X;
         this.FTongLingPractice.Y = FBoundsRendering.Y + this.FBoundsPractice.Y;
         var _loc2_:int = 0;
         while(this.tempIndex)
         {
            this.TPainterVec[_loc2_].X = FBoundsRendering.X + this.TBo[_loc2_].X;
            this.TPainterVec[_loc2_].Y = FBoundsRendering.Y + this.TBo[_loc2_].Y;
            _loc2_++;
            --this.tempIndex;
         }
      }
      
      override public function Show() : void
      {
         if(FContext == null)
         {
            return;
         }
         super.Show();
      }
      
      protected function getStr(param1:String) : Array
      {
         var _loc4_:int = 0;
         param1 = param1.substring(1,param1.length - 1);
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(true)
         {
            _loc3_ = param1.indexOf("[",_loc3_);
            if(_loc3_ == -1)
            {
               break;
            }
            _loc4_ = param1.indexOf("]",_loc3_);
            if(_loc4_ == -1)
            {
               return _loc2_;
            }
            _loc3_ += 1;
            _loc2_.push(param1.substring(_loc3_,_loc4_).split(","));
            _loc3_ = _loc4_;
         }
         return _loc2_;
      }
   }
}

