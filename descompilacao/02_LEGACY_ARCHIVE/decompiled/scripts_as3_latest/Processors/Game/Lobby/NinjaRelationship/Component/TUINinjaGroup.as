package Processors.Game.Lobby.NinjaRelationship.Component
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.Characters.THero;
   import Logics.NinjaRelation.TNinjaGroupBuff;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_WORLDMAP;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUINinjaGroup extends TProcessorUIResourceTemplate
   {
      
      protected var FMC_IsActivited:MovieClip;
      
      protected var FMC_Lookup:MovieClip;
      
      protected var FTF_Level:TextField;
      
      protected var FTF_GroupName:TextField;
      
      protected var FTF_Attribute:TextField;
      
      protected var FMC_Mistery:MovieClip;
      
      protected var FMC_Head:MovieClip;
      
      protected var FMC_Front:MovieClip;
      
      protected var FMC_Middle:MovieClip;
      
      protected var FMC_Back:MovieClip;
      
      protected var FBMP_Front:Bitmap;
      
      protected var FBMP_Middle:Bitmap;
      
      protected var FBMP_Back:Bitmap;
      
      protected var FHeadBitmaps:Vector.<Bitmap>;
      
      protected var FHeadIcons:Vector.<uint>;
      
      protected var FTextFilter:Array;
      
      protected var FOnLookupClick:Function;
      
      public function TUINinjaGroup(param1:TUIComponent)
      {
         super(param1);
         this.FBMP_Front = new Bitmap();
         this.FBMP_Middle = new Bitmap();
         this.FBMP_Back = new Bitmap();
         this.FHeadBitmaps = new Vector.<Bitmap>();
         this.FHeadIcons = new Vector.<uint>();
         this.FHeadBitmaps.push(this.FBMP_Front);
         this.FHeadBitmaps.push(this.FBMP_Middle);
         this.FHeadBitmaps.push(this.FBMP_Back);
      }
      
      override protected function UIDispatch() : void
      {
         this.FMC_IsActivited = FResource["MC_IsActivited"];
         this.FTF_Level = FResource["TF_Level"];
         this.FTF_GroupName = FResource["TF_GroupName"];
         this.FTF_Attribute = FResource["TF_Attribute"];
         this.FMC_Lookup = FResource["MC_Lookup"];
         TGameUtil.setButtonMode(this.FMC_Lookup,true);
         this.FMC_Head = FResource["MC_Head"];
         this.FMC_Front = this.FMC_Head["MC_Front"];
         this.FMC_Middle = this.FMC_Head["MC_Middle"];
         this.FMC_Back = this.FMC_Head["MC_Back"];
         this.FMC_Front.addChild(this.FBMP_Front);
         this.FMC_Middle.addChild(this.FBMP_Middle);
         this.FMC_Back.addChild(this.FBMP_Back);
         this.FMC_Mistery = FResource["MC_Mistery"];
         this.FTextFilter = this.FTF_Attribute.filters;
      }
      
      override protected function UILocations() : void
      {
         this.FMC_Lookup.addEventListener(MouseEvent.CLICK,this.MCLookupOnClick,false,0,true);
         super.UILocations();
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:TNinjaGroupBuff = null;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:THero = null;
         var _loc6_:String = null;
         if(FContext == null)
         {
            _loc4_ = this.FHeadBitmaps.length;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               this.FHeadBitmaps[_loc3_].bitmapData = null;
               _loc3_++;
            }
            return;
         }
         _loc1_ = FContext as TNinjaGroupBuff;
         this.FMC_IsActivited.gotoAndStop(uint(_loc1_.IsActivited) + 1);
         this.FTF_Level.text = STRING_WORLDMAP.STRINGS_LV + _loc1_.FriendLevel;
         this.FTF_GroupName.text = _loc1_.GroupName;
         _loc2_ = _loc1_.CurrentBuffDesc.split("_");
         if(_loc1_.IsMistery)
         {
            _loc6_ = _loc2_[0] + "\n" + _loc2_[1];
         }
         else if(_loc1_.ShenMiIsActivited)
         {
            _loc6_ = _loc2_[0] + "\n" + _loc2_[1] + "(+" + Math.floor(_loc2_[1] * _loc2_[2]) + ")" + _loc2_[3];
         }
         else
         {
            _loc6_ = _loc2_[0] + "\n" + _loc2_[1] + _loc2_[3];
         }
         this.FTF_Attribute.text = _loc6_;
         this.FTF_Attribute.filters = _loc1_.IsActivited ? this.FTextFilter : [TGameUtil.GaryColorFilters];
         this.FMC_Mistery.visible = _loc1_.IsMistery;
         _loc4_ = this.FHeadIcons.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this.FHeadIcons.pop();
            _loc3_++;
         }
         this.FHeadIcons.length = 0;
         _loc4_ = uint(_loc1_.Heros.Count);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc1_.Heros.GetHeroByIndex(_loc3_);
            this.FHeadBitmaps[_loc3_].filters = _loc5_.RecruitStatus ? [] : [TGameUtil.GaryColorFilters];
            this.FHeadIcons[_loc3_] = _loc5_.Identifier;
            _loc3_++;
         }
      }
      
      protected function MCLookupOnClick(param1:MouseEvent) : void
      {
         if(this.FOnLookupClick != null)
         {
            this.FOnLookupClick(this,FContext);
         }
      }
      
      public function set OnLookupClick(param1:Function) : void
      {
         this.FOnLookupClick = param1;
      }
      
      public function UpdataBitmap() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TNinjaGroupBuff = null;
         if(FContext != null)
         {
            _loc3_ = FContext as TNinjaGroupBuff;
            _loc2_ = uint(_loc3_.Heros.Count);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               TGameUtil.ShowImageByID(TGameUtil.Type_FettersSmall,this.FHeadBitmaps[_loc1_],CONST_MODULES.MODULE_NinjaRelation,this.FHeadIcons[_loc1_]);
               _loc1_++;
            }
         }
      }
   }
}

