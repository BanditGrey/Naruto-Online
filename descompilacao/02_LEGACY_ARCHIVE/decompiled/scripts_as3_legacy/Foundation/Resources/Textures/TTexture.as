package Foundation.Resources.Textures
{
   import Foundation.Common.TEntityList;
   import Foundation.Resources.Common.TResource;
   import Foundation.Resources.Spaces.ResourcesSpace;
   import flash.display.BitmapData;
   
   use namespace ResourcesSpace;
   
   public class TTexture extends TResource
   {
      
      protected var FAnimationSequences:TEntityList;
      
      protected var FSurface:BitmapData;
      
      public function TTexture(param1:uint)
      {
         super(param1);
         this.FAnimationSequences = new TEntityList();
      }
      
      ResourcesSpace function Coerce(param1:uint) : void
      {
         FIdentifier = param1;
      }
      
      ResourcesSpace function CoerceProperties(param1:BitmapData) : void
      {
         this.FSurface = param1;
      }
      
      ResourcesSpace function SequenceAppend(param1:TAnimationSequence) : void
      {
         this.FAnimationSequences.Add(param1);
      }
      
      public function get Surface() : BitmapData
      {
         return this.FSurface;
      }
      
      public function get Count() : int
      {
         return this.FAnimationSequences.Count;
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TAnimationSequence = null;
         _loc2_ = this.FAnimationSequences.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FAnimationSequences.GetEntityByIndex(_loc1_) as TAnimationSequence;
            _loc3_.Clear();
            _loc1_++;
         }
         this.FAnimationSequences.Clear();
      }
      
      public function GetAnimationSequenceByIndex(param1:int) : TAnimationSequence
      {
         return this.FAnimationSequences.GetEntityByIndex(param1) as TAnimationSequence;
      }
      
      public function GetAnimationSequenceByIdentifier(param1:uint) : TAnimationSequence
      {
         return this.FAnimationSequences.GetEntityByIdentifier(param1) as TAnimationSequence;
      }
   }
}

